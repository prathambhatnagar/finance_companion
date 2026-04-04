import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';

class DeleteTransactionUsecase extends Usecase<void, String> {
  DeleteTransactionUsecase({required this.transactionRepo});

  final TransactionRepo transactionRepo;

  @override
  Future<Either<Failure, void>> call({required String param}) async {
    return await transactionRepo.deleteTransactions(id: param);
  }
}
