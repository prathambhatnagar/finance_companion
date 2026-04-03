import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/domain/entities/transaction_entity.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();

  Future<Either<Failure, void>> addTransaction();

  Future<Either<Failure, void>> deleteTransactions({required String id});

  Future<Either<Failure, List<TransactionEntity>>> searchTransaction({
    required String query,
  });
}
