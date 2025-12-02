import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/transactions_bloc.dart';

/// Page for creating or editing a transaction
class TransactionFormPage extends StatefulWidget {
  final Transaction? transaction;

  const TransactionFormPage({super.key, this.transaction});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late TextEditingController _notesController;
  late TransactionType _selectedType;
  late PaymentMethod _selectedPaymentMethod;
  late DateTime _selectedDate;
  int? _selectedAccountId;
  int? _selectedToAccountId;

  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.transaction?.amount.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.transaction?.description ?? '',
    );
    _notesController = TextEditingController(
      text: widget.transaction?.notes ?? '',
    );
    _selectedType = widget.transaction?.type ?? TransactionType.expense;
    _selectedPaymentMethod =
        widget.transaction?.paymentMethod ?? PaymentMethod.upi;
    _selectedDate = widget.transaction?.date ?? DateTime.now();
    _selectedAccountId = widget.transaction?.accountId;
    _selectedToAccountId = widget.transaction?.toAccountId;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state.status == TransactionsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        } else if (state.status == TransactionsStatus.loaded &&
            state.selectedTransaction != null) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Transaction' : 'Add Transaction'),
          actions: [
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: _showDeleteDialog,
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: AppSpacing.pagePadding,
            children: [
              // Transaction Type
              Text(
                'Type',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              AppSpacing.vGapSm,
              _buildTypeSelector(),
              AppSpacing.vGapLg,

              // Amount
              AppTextField(
                controller: _amountController,
                label: 'Amount',
                hint: '0.00',
                prefixIcon: Icons.currency_rupee_rounded,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapLg,

              // Date
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: AppTextField(
                    label: 'Date',
                    hint: DateFormatter.format(_selectedDate),
                    prefixIcon: Icons.calendar_today_rounded,
                    initialValue: DateFormatter.format(_selectedDate),
                  ),
                ),
              ),
              AppSpacing.vGapLg,

              // Description
              AppTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'e.g., Grocery shopping',
                prefixIcon: Icons.description_rounded,
                textCapitalization: TextCapitalization.sentences,
              ),
              AppSpacing.vGapLg,

              // Payment Method
              Text(
                'Payment Method',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              AppSpacing.vGapSm,
              _buildPaymentMethodSelector(),
              AppSpacing.vGapLg,

              // Notes
              AppTextField(
                controller: _notesController,
                label: 'Notes (optional)',
                hint: 'Add notes',
                prefixIcon: Icons.notes_rounded,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              AppSpacing.vGapXxl,

              // Submit button
              BlocBuilder<TransactionsBloc, TransactionsState>(
                builder: (context, state) {
                  final isLoading = state.status == TransactionsStatus.loading;
                  return AppButton(
                    label: isEditing ? 'Save Changes' : 'Add Transaction',
                    onPressed: isLoading ? null : _submitForm,
                    isLoading: isLoading,
                    isExpanded: true,
                    size: AppButtonSize.large,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    final types = [
      TransactionType.expense,
      TransactionType.income,
      TransactionType.transfer,
    ];

    return Row(
      children: types.map((type) {
        final isSelected = _selectedType == type;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: type != types.last ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedType = type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? _getTypeColor(type).withOpacity(0.15)
                      : AppColors.surfaceLight,
                  borderRadius: AppRadius.radiusSm,
                  border: Border.all(
                    color: isSelected ? _getTypeColor(type) : AppColors.border,
                  ),
                ),
                child: Center(
                  child: Text(
                    type.displayName,
                    style: AppTypography.labelMedium.copyWith(
                      color: isSelected
                          ? _getTypeColor(type)
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getTypeColor(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return AppColors.positive;
      case TransactionType.expense:
        return AppColors.negative;
      case TransactionType.transfer:
        return AppColors.info;
      default:
        return AppColors.accent;
    }
  }

  Widget _buildPaymentMethodSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: PaymentMethod.values.map((method) {
        final isSelected = _selectedPaymentMethod == method;
        return ChoiceChip(
          label: Text(method.displayName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedPaymentMethod = method);
            }
          },
          selectedColor: AppColors.accentSurface,
          labelStyle: AppTypography.labelSmall.copyWith(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
        );
      }).toList(),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              surface: AppColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);

    if (isEditing) {
      final updatedTransaction = widget.transaction!.copyWith(
        date: _selectedDate,
        amount: amount,
        type: _selectedType,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        paymentMethod: _selectedPaymentMethod,
      );
      context
          .read<TransactionsBloc>()
          .add(UpdateTransactionEvent(updatedTransaction));
    } else {
      final newTransaction = Transaction.create(
        date: _selectedDate,
        amount: amount,
        type: _selectedType,
        accountId: _selectedAccountId ?? 1, // Default account
        toAccountId: _selectedToAccountId,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        paymentMethod: _selectedPaymentMethod,
      );
      context
          .read<TransactionsBloc>()
          .add(CreateTransactionEvent(newTransaction));
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .read<TransactionsBloc>()
                  .add(DeleteTransactionEvent(widget.transaction!.id));
              Navigator.of(context).pop();
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

