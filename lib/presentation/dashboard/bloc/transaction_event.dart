import 'package:finance_companion/domain/entities/transaction_entity.dart';

abstract class TransactionEvent {}

class GetAllTransactionEvent extends TransactionEvent {}

class FetchAllDebitTransactionEvent extends TransactionEvent {}

class FetchAllCreditTransactionEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  AddTransactionEvent({required this.transactionId, required this.transaction});
  final TransactionEntity transaction;
  final String transactionId;
}

class DeleteTransactionEvent extends TransactionEvent {
  DeleteTransactionEvent({required this.transactionId});
  final String transactionId;
}
