import 'package:finance_companion/domain/entities/category_entity.dart';

class TransactionEntity {
  TransactionEntity({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timeStamp,
    required this.category,
  });

  String id;
  TransactionTypeEntity type;
  double amount;
  String note;
  DateTime timeStamp;
  CategoryEntity category;
}

enum TransactionTypeEntity { credit, debit }
