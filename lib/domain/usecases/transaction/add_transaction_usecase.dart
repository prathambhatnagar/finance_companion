import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';
import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/entities/transaction_entity.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';

class AddTransactionUsecase extends Usecase<void, AddTransactionPram> {
  AddTransactionUsecase({required this.transactionRepo});

  final TransactionRepo transactionRepo;

  @override
  Future<Either<Failure, void>> call({
    required AddTransactionPram param,
  }) async {
    return await transactionRepo.addTransaction(
      id: param.id,
      transaction: param.transaction,
    );
  }
}

class AddTransactionPram {
  AddTransactionPram({required this.id, required this.transaction});
  final String id;
  final TransactionEntity transaction;
}
