import 'package:finance_companion/data/models/transaction_model/category_model.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timeStamp,
    required this.category,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  TransactionTypeModel type;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String note;

  @HiveField(4)
  DateTime timeStamp;

  @HiveField(5)
  CategoryModel category;

  factory TransactionModel.fromEntity({
    required TransactionEntity transactionEntity,
  }) {
    return TransactionModel(
      id: transactionEntity.id,
      note: transactionEntity.note,
      amount: transactionEntity.amount,
      type: transactionEntity.type == TransactionTypeEntity.credit
          ? TransactionTypeModel.credit
          : TransactionTypeModel.debit,
      timeStamp: transactionEntity.timeStamp,
      category: CategoryModel.fromEntity(
        categoryEntity: transactionEntity.category,
      ),
    );
  }
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      note: note,
      amount: amount,
      type: type == TransactionTypeModel.credit
          ? TransactionTypeEntity.credit
          : TransactionTypeEntity.debit,
      timeStamp: timeStamp,
      category: category.toEntity(),
    );
  }
}

@HiveType(typeId: 2)
enum TransactionTypeModel {
  @HiveField(0)
  credit,
  @HiveField(1)
  debit,
}
