import 'package:finance_companion/data/models/account_model/account_model.dart';
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
    this.category,
    required this.account,
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
  CategoryModel? category;

  @HiveField(6)
  AccountModel account;

  factory TransactionModel.fromEntity({
    required TransactionEntity transactionEntity,
  }) {
    return TransactionModel(
      id: transactionEntity.id,
      note: transactionEntity.note,
      amount: transactionEntity.amount,
      type: transactionEntity.type == TransactionTypeEntity.income
          ? TransactionTypeModel.income
          : TransactionTypeModel.expense,
      timeStamp: transactionEntity.timeStamp,
      category: transactionEntity.category != null
          ? CategoryModel.fromEntity(
              categoryEntity: transactionEntity.category!,
            )
          : null,
      account: AccountModel.fromEntity(transactionEntity.account),
    );
  }
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      note: note,
      amount: amount,
      type: type == TransactionTypeModel.income
          ? TransactionTypeEntity.income
          : TransactionTypeEntity.expense,
      timeStamp: timeStamp,
      category: category?.toEntity(),
      account: account.toEntity(),
    );
  }
}

@HiveType(typeId: 2)
enum TransactionTypeModel {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}
