import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class TransactionLocalService {
  Future<List<TransactionModel>> getAllTransactions();

  Future<void> addTransaction({required TransactionModel transaction});

  Future<void> deleteTransaction({required TransactionModel transaction});

  Future<TransactionModel> getTransaction({required String transactionId});
}

class TransactionLocalServiceImpl extends TransactionLocalService {
  final String _boxName = 'transactions_box';

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionsBox = Hive.box(_boxName);
    final transactions = transactionsBox.values
        .cast<TransactionModel>()
        .toList();
    return transactions;
  }

  @override
  Future<void> addTransaction({required TransactionModel transaction}) async {
    final transactionsBox = Hive.box(_boxName);
    await transactionsBox.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction({
    required TransactionModel transaction,
  }) async {
    final transactionsBox = Hive.box(_boxName);
    await transactionsBox.delete(transaction.id);
  }

  @override
  Future<TransactionModel> getTransaction({
    required String transactionId,
  }) async {
    final transactionsBox = Hive.box(_boxName);
    return transactionsBox.get(transactionId);
  }
}
