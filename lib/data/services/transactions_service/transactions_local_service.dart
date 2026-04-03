import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class TransactionsLocalService {
  Future<List<TransactionModel>> getAllTransactions();

  Future<void> saveTransaction({
    required String transactionId,
    required TransactionModel transaction,
  });

  Future<void> deleteTransaction({required String transactionId});

  Future<TransactionModel> getTransaction({required String transactionId});
}

class TransactionLocalServiceImpl extends TransactionsLocalService {
  final String _boxName = 'transaction_box';

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionsBox = Hive.box(_boxName);
    final transactions = transactionsBox.values
        .cast<TransactionModel>()
        .toList();

    return transactions;
  }

  @override
  Future<void> saveTransaction({
    required String transactionId,
    required TransactionModel transaction,
  }) async {
    final transactionsBox = Hive.box(_boxName);
    await transactionsBox.put(transactionId, transaction);
  }

  @override
  Future<void> deleteTransaction({required String transactionId}) async {
    final transactionsBox = Hive.box(_boxName);
    await transactionsBox.delete(transactionId);
  }

  @override
  Future<TransactionModel> getTransaction({
    required String transactionId,
  }) async {
    final transactionsBox = Hive.box(_boxName);
    return await transactionsBox.get(transactionId);
  }
}
