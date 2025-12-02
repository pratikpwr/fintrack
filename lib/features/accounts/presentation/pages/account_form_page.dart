import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account.dart';
import '../bloc/accounts_bloc.dart';

/// Page for creating or editing an account
class AccountFormPage extends StatefulWidget {
  final Account? account;

  const AccountFormPage({super.key, this.account});

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _descriptionController;
  late AccountType _selectedType;

  bool get isEditing => widget.account != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account?.name ?? '');
    _balanceController = TextEditingController(
      text: widget.account?.balance.toString() ?? '0',
    );
    _bankNameController =
        TextEditingController(text: widget.account?.bankName ?? '');
    _accountNumberController =
        TextEditingController(text: widget.account?.accountNumber ?? '');
    _descriptionController =
        TextEditingController(text: widget.account?.description ?? '');
    _selectedType = widget.account?.type ?? AccountType.bank;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountsBloc, AccountsState>(
      listener: (context, state) {
        if (state.status == AccountsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        } else if (state.status == AccountsStatus.loaded &&
            state.selectedAccount != null) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Account' : 'Add Account'),
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
              // Account Type
              Text(
                'Account Type',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              AppSpacing.vGapSm,
              _buildTypeSelector(),
              AppSpacing.vGapLg,

              // Name
              AppTextField(
                controller: _nameController,
                label: 'Account Name',
                hint: 'e.g., HDFC Savings',
                prefixIcon: Icons.account_balance_rounded,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter account name';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapLg,

              // Balance
              AppTextField(
                controller: _balanceController,
                label: 'Current Balance',
                hint: '0.00',
                prefixIcon: Icons.currency_rupee_rounded,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              AppSpacing.vGapLg,

              // Bank Name (for bank accounts)
              if (_selectedType == AccountType.bank ||
                  _selectedType == AccountType.fixedDeposit) ...[
                AppTextField(
                  controller: _bankNameController,
                  label: 'Bank Name',
                  hint: 'e.g., HDFC Bank',
                  prefixIcon: Icons.business_rounded,
                  textCapitalization: TextCapitalization.words,
                ),
                AppSpacing.vGapLg,
              ],

              // Account Number (for bank accounts)
              if (_selectedType == AccountType.bank) ...[
                AppTextField(
                  controller: _accountNumberController,
                  label: 'Account Number (optional)',
                  hint: 'Last 4 digits',
                  prefixIcon: Icons.numbers_rounded,
                  keyboardType: TextInputType.number,
                ),
                AppSpacing.vGapLg,
              ],

              // Description
              AppTextField(
                controller: _descriptionController,
                label: 'Description (optional)',
                hint: 'Add notes about this account',
                prefixIcon: Icons.notes_rounded,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              AppSpacing.vGapXxl,

              // Submit button
              BlocBuilder<AccountsBloc, AccountsState>(
                builder: (context, state) {
                  final isLoading = state.status == AccountsStatus.loading;
                  return AppButton(
                    label: isEditing ? 'Save Changes' : 'Add Account',
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AccountType.values
          .where((type) => type != AccountType.creditCard) // Handled separately
          .map((type) {
        final isSelected = _selectedType == type;
        return ChoiceChip(
          label: Text(type.displayName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedType = type);
            }
          },
          selectedColor: AppColors.accentSurface,
          labelStyle: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
        );
      }).toList(),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final balance = double.tryParse(_balanceController.text) ?? 0;

    if (isEditing) {
      final updatedAccount = widget.account!.copyWith(
        name: _nameController.text.trim(),
        type: _selectedType,
        balance: balance,
        bankName: _bankNameController.text.trim().isEmpty
            ? null
            : _bankNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim().isEmpty
            ? null
            : _accountNumberController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
      context.read<AccountsBloc>().add(UpdateAccountEvent(updatedAccount));
    } else {
      final newAccount = Account.create(
        name: _nameController.text.trim(),
        type: _selectedType,
        balance: balance,
        bankName: _bankNameController.text.trim().isEmpty
            ? null
            : _bankNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim().isEmpty
            ? null
            : _accountNumberController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
      context.read<AccountsBloc>().add(CreateAccountEvent(newAccount));
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete this account? This action cannot be undone.',
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
                  .read<AccountsBloc>()
                  .add(DeleteAccountEvent(widget.account!.id, permanent: true));
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

