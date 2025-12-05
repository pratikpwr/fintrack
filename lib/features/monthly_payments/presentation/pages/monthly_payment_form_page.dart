import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/monthly_payment.dart';
import '../bloc/monthly_payments_bloc.dart';

/// Form page for creating/editing monthly payments
class MonthlyPaymentFormPage extends StatefulWidget {
  final MonthlyPayment? payment;

  const MonthlyPaymentFormPage({super.key, this.payment});

  @override
  State<MonthlyPaymentFormPage> createState() => _MonthlyPaymentFormPageState();
}

class _MonthlyPaymentFormPageState extends State<MonthlyPaymentFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _dueDayController;
  late TextEditingController _descriptionController;
  late PaymentCategory _selectedCategory;
  late PaymentFrequency _selectedFrequency;
  late bool _autoDebit;

  bool get isEditing => widget.payment != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.payment?.name);
    _amountController = TextEditingController(
      text: widget.payment?.amount.toString(),
    );
    _dueDayController = TextEditingController(
      text: widget.payment?.dueDay.toString() ?? '1',
    );
    _descriptionController =
        TextEditingController(text: widget.payment?.description);
    _selectedCategory = widget.payment?.category ?? PaymentCategory.subscription;
    _selectedFrequency = widget.payment?.frequency ?? PaymentFrequency.monthly;
    _autoDebit = widget.payment?.autoDebit ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dueDayController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MonthlyPaymentsBloc, MonthlyPaymentsState>(
      listener: (context, state) {
        if (state.status == MonthlyPaymentsStatus.loaded &&
            state.selectedPayment != null) {
          Navigator.of(context).pop();
        } else if (state.status == MonthlyPaymentsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
              backgroundColor: AppColors.negative,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Payment' : 'Add Payment'),
          actions: [
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: _showDeleteConfirmation,
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: AppSpacing.pagePadding,
            children: [
              // Name field
              AppTextField(
                controller: _nameController,
                label: 'Payment Name',
                hint: 'e.g., Netflix, Electricity Bill',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter payment name';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Amount field
              AppTextField(
                controller: _amountController,
                label: 'Amount',
                hint: 'Payment amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                prefix: const Text('₹ '),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Category dropdown
              _buildCategoryDropdown(),
              AppSpacing.vGapMd,

              // Frequency dropdown
              _buildFrequencyDropdown(),
              AppSpacing.vGapMd,

              // Due day field
              AppTextField(
                controller: _dueDayController,
                label: 'Due Day of Month',
                hint: '1-31',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter due day';
                  }
                  final day = int.tryParse(value);
                  if (day == null || day < 1 || day > 31) {
                    return 'Due day must be between 1 and 31';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Auto debit toggle
              _buildAutoDebitToggle(),
              AppSpacing.vGapMd,

              // Description field
              AppTextField(
                controller: _descriptionController,
                label: 'Description (Optional)',
                hint: 'Any additional notes',
                maxLines: 3,
              ),
              AppSpacing.vGapLg,

              // Preview card
              _buildPreviewCard(),
              AppSpacing.vGapLg,

              // Submit button
              BlocBuilder<MonthlyPaymentsBloc, MonthlyPaymentsState>(
                builder: (context, state) {
                  final isLoading =
                      state.status == MonthlyPaymentsStatus.loading;
                  return AppButton(
                    label: isEditing ? 'Update Payment' : 'Add Payment',
                    onPressed: isLoading ? null : _submitForm,
                    isLoading: isLoading,
                  );
                },
              ),
              AppSpacing.vGapXl,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: AppTypography.labelMedium),
        AppSpacing.vGapXs,
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PaymentCategory>(
              value: _selectedCategory,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              dropdownColor: AppColors.surface,
              borderRadius: AppRadius.radiusMd,
              items: PaymentCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child:
                      Text(category.displayName, style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrequencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frequency', style: AppTypography.labelMedium),
        AppSpacing.vGapXs,
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PaymentFrequency>(
              value: _selectedFrequency,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              dropdownColor: AppColors.surface,
              borderRadius: AppRadius.radiusMd,
              items: PaymentFrequency.values.map((frequency) {
                return DropdownMenuItem(
                  value: frequency,
                  child: Text(frequency.displayName,
                      style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedFrequency = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutoDebitToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auto Debit', style: AppTypography.labelMedium),
                Text(
                  'Payment is automatically debited',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          Switch(
            value: _autoDebit,
            onChanged: (value) => setState(() => _autoDebit = value),
            activeColor: AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final monthlyAmount = amount / _selectedFrequency.monthsInterval;
    final yearlyAmount = amount * (12 / _selectedFrequency.monthsInterval);

    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview', style: AppTypography.labelMedium),
          AppSpacing.vGapMd,
          _buildPreviewRow('Payment Amount', amount),
          AppSpacing.vGapSm,
          _buildPreviewRow('Monthly Equivalent', monthlyAmount),
          AppSpacing.vGapSm,
          Divider(color: AppColors.border),
          AppSpacing.vGapSm,
          _buildPreviewRow('Yearly Total', yearlyAmount, isBold: true),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)
              : AppTypography.bodySmall,
        ),
        MoneyText(
          amount: amount,
          size: MoneyTextSize.small,
          style: isBold
              ? AppTypography.moneySmall.copyWith(fontWeight: FontWeight.w600)
              : null,
        ),
      ],
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final dueDay = int.parse(_dueDayController.text);
    final now = DateTime.now();

    // Calculate next due date
    var nextDueDate = DateTime(now.year, now.month, dueDay);
    if (now.day > dueDay) {
      final nextMonth = now.month + 1;
      final year = now.year + (nextMonth - 1) ~/ 12;
      final month = ((nextMonth - 1) % 12) + 1;
      nextDueDate = DateTime(year, month, dueDay);
    }

    final payment = MonthlyPayment(
      id: widget.payment?.id ?? 0,
      name: _nameController.text.trim(),
      amount: double.parse(_amountController.text),
      category: _selectedCategory,
      frequency: _selectedFrequency,
      dueDay: dueDay,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      isActive: widget.payment?.isActive ?? true,
      autoDebit: _autoDebit,
      lastPaidDate: widget.payment?.lastPaidDate,
      nextDueDate: widget.payment?.nextDueDate ?? nextDueDate,
      createdAt: widget.payment?.createdAt ?? now,
      updatedAt: now,
    );

    if (isEditing) {
      context
          .read<MonthlyPaymentsBloc>()
          .add(UpdateMonthlyPaymentEvent(payment));
    } else {
      context
          .read<MonthlyPaymentsBloc>()
          .add(CreateMonthlyPaymentEvent(payment));
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Payment'),
        content: const Text('Are you sure you want to delete this payment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              this
                  .context
                  .read<MonthlyPaymentsBloc>()
                  .add(DeleteMonthlyPaymentEvent(widget.payment!.id));
              Navigator.of(this.context).pop();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.negative),
            ),
          ),
        ],
      ),
    );
  }
}

