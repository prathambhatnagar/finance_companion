import 'package:finance_companion/domain/entities/account/account_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account_model.g.dart';

@HiveType(typeId: 3)
class AccountModel {
  const AccountModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.colorHex,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double balance;
  @HiveField(3)
  final String colorHex;

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      name: name,
      balance: balance,
      colorHex: colorHex,
    );
  }

  factory AccountModel.fromEntity(AccountEntity accountEntity) {
    return AccountModel(
      id: accountEntity.id,
      name: accountEntity.name,
      balance: accountEntity.balance,
      colorHex: accountEntity.colorHex,
    );
  }
}
