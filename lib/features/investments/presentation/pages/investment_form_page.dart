import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/investment.dart';
import '../bloc/investments_bloc.dart';

/// Form page for creating/editing investments
class InvestmentFormPage extends StatefulWidget {
  final Investment? investment;

  const InvestmentFormPage({super.key, this.investment});

  @override
  State<InvestmentFormPage> createState() => _InvestmentFormPageState();
}

class _InvestmentFormPageState extends State<InvestmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _symbolController;
  late TextEditingController _quantityController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _currentPriceController;
  late TextEditingController _notesController;
  late InvestmentType _selectedType;
  late DateTime _purchaseDate;

  bool get isEditing => widget.investment != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.investment?.name);
    _symbolController = TextEditingController(text: widget.investment?.symbol);
    _quantityController = TextEditingController(
      text: widget.investment?.quantity.toString(),
    );
    _purchasePriceController = TextEditingController(
      text: widget.investment?.purchasePrice.toString(),
    );
    _currentPriceController = TextEditingController(
      text: widget.investment?.currentPrice.toString(),
    );
    _notesController = TextEditingController(text: widget.investment?.notes);
    _selectedType = widget.investment?.type ?? InvestmentType.stock;
    _purchaseDate = widget.investment?.purchaseDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _symbolController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _currentPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvestmentsBloc, InvestmentsState>(
      listener: (context, state) {
        if (state.status == InvestmentsStatus.loaded &&
            state.selectedInvestment != null) {
          Navigator.of(context).pop();
        } else if (state.status == InvestmentsStatus.error) {
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
          title: Text(isEditing ? 'Edit Investment' : 'Add Investment'),
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
                label: 'Investment Name',
                hint: 'e.g., Reliance Industries',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter investment name';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Symbol field
              AppTextField(
                controller: _symbolController,
                label: 'Symbol (Optional)',
                hint: 'e.g., RELIANCE, NIFTY50',
              ),
              AppSpacing.vGapMd,

              // Type dropdown
              _buildTypeDropdown(),
              AppSpacing.vGapMd,

              // Quantity field
              AppTextField(
                controller: _quantityController,
                label: 'Quantity',
                hint: 'Number of units',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter quantity';
                  }
                  final qty = double.tryParse(value);
                  if (qty == null || qty <= 0) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Purchase price field
              AppTextField(
                controller: _purchasePriceController,
                label: 'Purchase Price (per unit)',
                hint: 'Price per unit when bought',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                prefix: const Text('₹ '),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter purchase price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price < 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Current price field
              AppTextField(
                controller: _currentPriceController,
                label: 'Current Price (per unit)',
                hint: 'Current market price',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                prefix: const Text('₹ '),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter current price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price < 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapMd,

              // Purchase date field
              _buildDateField(),
              AppSpacing.vGapMd,

              // Notes field
              AppTextField(
                controller: _notesController,
                label: 'Notes (Optional)',
                hint: 'Any additional notes',
                maxLines: 3,
              ),
              AppSpacing.vGapLg,

              // Preview card
              _buildPreviewCard(),
              AppSpacing.vGapLg,

              // Submit button
              BlocBuilder<InvestmentsBloc, InvestmentsState>(
                builder: (context, state) {
                  final isLoading = state.status == InvestmentsStatus.loading;
                  return AppButton(
                    label: isEditing ? 'Update Investment' : 'Add Investment',
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

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Investment Type', style: AppTypography.labelMedium),
        AppSpacing.vGapXs,
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusMd,
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InvestmentType>(
              value: _selectedType,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              dropdownColor: AppColors.surface,
              borderRadius: AppRadius.radiusMd,
              items: InvestmentType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName, style: AppTypography.bodyMedium),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedType = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Purchase Date', style: AppTypography.labelMedium),
        AppSpacing.vGapXs,
        InkWell(
          onTap: _selectDate,
          borderRadius: AppRadius.radiusMd,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.radiusMd,
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 20, color: AppColors.textSecondary),
                AppSpacing.hGapSm,
                Text(
                  '${_purchaseDate.day}/${_purchaseDate.month}/${_purchaseDate.year}',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewCard() {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0;
    final currentPrice = double.tryParse(_currentPriceController.text) ?? 0;

    final invested = quantity * purchasePrice;
    final currentValue = quantity * currentPrice;
    final profitLoss = currentValue - invested;
    final profitLossPercent =
        invested > 0 ? (profitLoss / invested) * 100 : 0.0;

    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview', style: AppTypography.labelMedium),
          AppSpacing.vGapMd,
          _buildPreviewRow('Invested Amount', invested),
          AppSpacing.vGapSm,
          _buildPreviewRow('Current Value', currentValue),
          AppSpacing.vGapSm,
          Divider(color: AppColors.border),
          AppSpacing.vGapSm,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profit/Loss', style: AppTypography.bodySmall),
              Row(
                children: [
                  MoneyText(
                    amount: profitLoss,
                    size: MoneyTextSize.small,
                    style: AppTypography.bodyMedium.copyWith(
                      color: profitLoss >= 0
                          ? AppColors.positive
                          : AppColors.negative,
                      fontWeight: FontWeight.w600,
                    ),
                    showSign: true,
                  ),
                  AppSpacing.hGapXs,
                  Text(
                    '(${profitLossPercent.toStringAsFixed(2)}%)',
                    style: AppTypography.caption.copyWith(
                      color: profitLoss >= 0
                          ? AppColors.positive
                          : AppColors.negative,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodySmall),
        MoneyText(amount: amount, size: MoneyTextSize.small),
      ],
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
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
      setState(() => _purchaseDate = picked);
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final investment = Investment(
      id: widget.investment?.id ?? 0,
      name: _nameController.text.trim(),
      symbol: _symbolController.text.trim().isEmpty
          ? null
          : _symbolController.text.trim().toUpperCase(),
      type: _selectedType,
      quantity: double.parse(_quantityController.text),
      purchasePrice: double.parse(_purchasePriceController.text),
      currentPrice: double.parse(_currentPriceController.text),
      purchaseDate: _purchaseDate,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      isActive: widget.investment?.isActive ?? true,
      createdAt: widget.investment?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (isEditing) {
      context.read<InvestmentsBloc>().add(UpdateInvestmentEvent(investment));
    } else {
      context.read<InvestmentsBloc>().add(CreateInvestmentEvent(investment));
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Investment'),
        content: const Text('Are you sure you want to delete this investment?'),
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
                  .read<InvestmentsBloc>()
                  .add(DeleteInvestmentEvent(widget.investment!.id));
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

