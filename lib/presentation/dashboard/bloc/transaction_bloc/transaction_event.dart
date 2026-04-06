import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';

abstract class TransactionEvent {}

class GetAllTransactionEvent extends TransactionEvent {}

class GetAllDebitTransactionEvent extends TransactionEvent {}

class GetAllCreditTransactionEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  AddTransactionEvent({required this.transaction});
  final TransactionEntity transaction;
}

class DeleteTransactionEvent extends TransactionEvent {
  DeleteTransactionEvent({required this.transaction});
  final TransactionEntity transaction;
}
