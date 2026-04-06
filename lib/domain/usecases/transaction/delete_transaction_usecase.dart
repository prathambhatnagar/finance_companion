import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/domain/repositories/account_repo/account_repo.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';

class DeleteTransactionUsecase extends Usecase<void, TransactionEntity> {
  DeleteTransactionUsecase({
    required this.transactionRepo,
    required this.accountRepo,
  });

  final TransactionRepo transactionRepo;
  final AccountRepo accountRepo;

  @override
  Future<Either<Failure, void>> call({required TransactionEntity param}) async {
    final txResult = await transactionRepo.deleteTransactions(
      transaction: param,
    );
    return txResult.fold((failure) => left(failure), (_) async {
      final accountResult = await accountRepo.getAccountById(param.accountId);
      return accountResult.fold((failure) => left(failure), (account) async {
        double updatedAccount = account.balance;

        if (param.type == TransactionTypeEntity.income) {
          updatedAccount -= param.amount;
        } else {
          updatedAccount += param.amount;
        }
        return await accountRepo.updataAccountBalance(
          id: account.id,
          newBalance: updatedAccount,
        );
      });
    });
  }
}
