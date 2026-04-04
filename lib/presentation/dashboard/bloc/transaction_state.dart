import 'package:finance_companion/domain/entities/transaction_entity.dart';

abstract class TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  TransactionErrorState({required this.message});
  String message;
}

class TransactionLoadedState extends TransactionState {
  TransactionLoadedState({required this.transactionsList});
  final List<TransactionEntity> transactionsList;
}
