import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:finance_companion/domain/entities/transaction/category_entity.dart';

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.note,
    required this.amount,
    this.previous,
    required this.type,
    required this.timeStamp,
    this.category,
    required this.account,
  });

  final String id;
  final TransactionTypeEntity type;
  final double amount;
  final double? previous;
  final String note;
  final DateTime timeStamp;
  final TransactionCategoryEntity? category;
  final AccountEntity account;
}

enum TransactionTypeEntity { income, expense }
