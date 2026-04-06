import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:finance_companion/data/services/transactions_service/local_transactions_service.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';

class TransactionRepoImpl extends TransactionRepo {
  TransactionRepoImpl({required this.transactionsLocalService});
  TransactionLocalService transactionsLocalService;

  @override
  Future<Either<Failure, void>> addTransaction({
    required TransactionEntity transaction,
  }) async {
    try {
      final result = await transactionsLocalService.addTransaction(
        transaction: TransactionModel.fromEntity(
          transactionEntity: transaction,
        ),
      );
      return right(result);
    } catch (e) {
      log(e.toString());
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransactions({
    required TransactionEntity transaction,
  }) async {
    try {
      final result = await transactionsLocalService.deleteTransaction(
        transaction: TransactionModel.fromEntity(
          transactionEntity: transaction,
        ),
      );
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<TransactionEntity>>> getAllCreditTransactions() {
  //   // TODO: implement getAllCreditTransactions
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<TransactionEntity>>> getAllDebitTransactions() {
  //   // TODO: implement getAllDebitTransactions
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    try {
      final result = await transactionsLocalService.getAllTransactions();
      final transactions = result.map((e) => e.toEntity()).toList();
      return right(transactions);
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> getTransaction({
    required String query,
  }) async {
    try {
      final result = await transactionsLocalService.getTransaction(
        transactionId: query,
      );
      return right(result.toEntity());
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
