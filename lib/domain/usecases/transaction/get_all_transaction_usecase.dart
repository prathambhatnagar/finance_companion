import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/entities/transaction_entity.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';

class GetAllTransactionUsecase extends Usecase<void, NoParam> {
  GetAllTransactionUsecase({required this.transactionRepo});

  final TransactionRepo transactionRepo;

  @override
  Future<Either<Failure, List<TransactionEntity>>> call({
    required NoParam param,
  }) async {
    return await transactionRepo.getAllTransactions();
  }
}
