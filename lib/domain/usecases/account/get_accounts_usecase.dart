import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:finance_companion/domain/repositories/account_repo/account_repo.dart';

class GetAccountsUsecase extends Usecase<List<AccountEntity>, NoParam> {
  GetAccountsUsecase({required this.accountRepo});
  AccountRepo accountRepo;

  @override
  Future<Either<Failure, List<AccountEntity>>> call({
    required NoParam param,
  }) async {
    return await accountRepo.getAccounts();
  }
}
