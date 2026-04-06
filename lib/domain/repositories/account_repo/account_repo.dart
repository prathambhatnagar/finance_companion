import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';

abstract class AccountRepo {
  Future<Either<Failure, List<AccountEntity>>> getAccounts();

  Future<Either<Failure, AccountEntity>> getAccountById(String id);

  Future<Either<Failure, void>> updataAccountBalance({
    required String id,
    required double newBalance,
    required double previousBalance,
  });

  Future<Either<Failure, void>> seedDefaultAccounts();
}
