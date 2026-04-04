import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/data/services/account_service/local_account_service.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:finance_companion/domain/repositories/account_repo/account_repo.dart';

class AccountRepoImpl extends AccountRepo {
  AccountRepoImpl({required this.localAccountService});
  LocalAccountService localAccountService;

  @override
  Future<Either<Failure, AccountEntity>> getAccountById(String id) async {
    try {
      final result = await localAccountService.getAccountById(id);
      return right(result.toEntity());
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AccountEntity>>> getAccounts() async {
    try {
      final result = await localAccountService.getAccounts();
      final accounts = result.map((e) => e.toEntity()).toList();
      return right(accounts);
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> seedDefaultAccounts() async {
    try {
      final result = await localAccountService.seedDefaultAccounts();
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updataAccountBalance({
    required String id,
    required double newBalance,
  }) async {
    try {
      final result = await localAccountService.updataAccountBalance(
        id: id,
        newBalance: newBalance,
      );

      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
