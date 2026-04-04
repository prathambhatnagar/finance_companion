import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();

  // Future<Either<Failure, List<TransactionEntity>>> getAllCreditTransactions();

  // Future<Either<Failure, List<TransactionEntity>>> getAllDebitTransactions();

  Future<Either<Failure, void>> addTransaction({
    required TransactionEntity transaction,
  });

  Future<Either<Failure, void>> deleteTransactions({required String id});

  Future<Either<Failure, TransactionEntity>> getTransaction({
    required String query,
  });
}
