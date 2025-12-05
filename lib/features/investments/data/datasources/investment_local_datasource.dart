import 'package:isar/isar.dart';
import '../../domain/entities/investment.dart';
import '../models/investment_model.dart';

/// Interface for investment local data source
abstract class InvestmentLocalDataSource {
  /// Get all investments
  Future<List<InvestmentModel>> getInvestments({bool includeInactive = false});

  /// Get investment by ID
  Future<InvestmentModel?> getInvestmentById(int id);

  /// Get investments by type
  Future<List<InvestmentModel>> getInvestmentsByType(InvestmentType type);

  /// Get investments by linked account
  Future<List<InvestmentModel>> getInvestmentsByAccount(int accountId);

  /// Create a new investment
  Future<InvestmentModel> createInvestment(InvestmentModel investment);

  /// Update an existing investment
  Future<InvestmentModel> updateInvestment(InvestmentModel investment);

  /// Delete an investment
  Future<void> deleteInvestment(int id);

  /// Watch investments for changes
  Stream<List<InvestmentModel>> watchInvestments({bool includeInactive = false});

  /// Get total invested amount
  Future<double> getTotalInvestedAmount();

  /// Get total current value
  Future<double> getTotalCurrentValue();
}

/// Implementation of InvestmentLocalDataSource using Isar
class InvestmentLocalDataSourceImpl implements InvestmentLocalDataSource {
  final Isar isar;

  InvestmentLocalDataSourceImpl({required this.isar});

  @override
  Future<List<InvestmentModel>> getInvestments({
    bool includeInactive = false,
  }) async {
    if (includeInactive) {
      return isar.investmentModels.where().findAll();
    }
    return isar.investmentModels.filter().isActiveEqualTo(true).findAll();
  }

  @override
  Future<InvestmentModel?> getInvestmentById(int id) async {
    return isar.investmentModels.get(id);
  }

  @override
  Future<List<InvestmentModel>> getInvestmentsByType(
    InvestmentType type,
  ) async {
    return isar.investmentModels
        .filter()
        .typeEqualTo(type)
        .and()
        .isActiveEqualTo(true)
        .findAll();
  }

  @override
  Future<List<InvestmentModel>> getInvestmentsByAccount(int accountId) async {
    return isar.investmentModels
        .filter()
        .linkedAccountIdEqualTo(accountId)
        .and()
        .isActiveEqualTo(true)
        .findAll();
  }

  @override
  Future<InvestmentModel> createInvestment(InvestmentModel investment) async {
    await isar.writeTxn(() async {
      investment.id = await isar.investmentModels.put(investment);
    });
    return investment;
  }

  @override
  Future<InvestmentModel> updateInvestment(InvestmentModel investment) async {
    await isar.writeTxn(() async {
      await isar.investmentModels.put(investment);
    });
    return investment;
  }

  @override
  Future<void> deleteInvestment(int id) async {
    await isar.writeTxn(() async {
      await isar.investmentModels.delete(id);
    });
  }

  @override
  Stream<List<InvestmentModel>> watchInvestments({
    bool includeInactive = false,
  }) {
    if (includeInactive) {
      return isar.investmentModels.where().watch(fireImmediately: true);
    }
    return isar.investmentModels
        .filter()
        .isActiveEqualTo(true)
        .watch(fireImmediately: true);
  }

  @override
  Future<double> getTotalInvestedAmount() async {
    final investments = await getInvestments();
    return investments.fold<double>(
      0,
      (sum, inv) => sum + (inv.quantity * inv.purchasePrice),
    );
  }

  @override
  Future<double> getTotalCurrentValue() async {
    final investments = await getInvestments();
    return investments.fold<double>(
      0,
      (sum, inv) => sum + (inv.quantity * inv.currentPrice),
    );
  }
}

