import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Import all collection models here
import '../../features/accounts/data/models/account_model.dart';
import '../../features/transactions/data/models/transaction_model.dart';

/// Database service for Isar initialization and access
class DatabaseService {
  static Isar? _isar;

  /// Get the Isar instance
  static Isar get instance {
    if (_isar == null) {
      throw StateError('Database not initialized. Call initialize() first.');
    }
    return _isar!;
  }

  /// Initialize the Isar database
  static Future<void> initialize() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        AccountModelSchema,
        TransactionModelSchema,
      ],
      directory: dir.path,
      name: 'fintrack',
      inspector: true, // Enable inspector for debugging
    );
  }

  /// Close the database
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Clear all data (for testing or reset)
  static Future<void> clearAll() async {
    await _isar?.writeTxn(() async {
      await _isar!.clear();
    });
  }
}

