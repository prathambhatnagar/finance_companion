import 'package:finance_companion/domain/entities/transaction/category_entity.dart';

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timeStamp,
    required this.category,
    required this.accountId,
  });

  final String id;
  final TransactionTypeEntity type;
  final double amount;
  final String note;
  final DateTime timeStamp;
  final TransactionCategoryEntity category;
  final String accountId;
}

enum TransactionTypeEntity { income, expense }
