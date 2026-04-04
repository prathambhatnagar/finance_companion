import 'package:finance_companion/domain/entities/transaction/category_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.colorHex,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String iconPath;

  @HiveField(3)
  final int colorHex;

  factory CategoryModel.fromEntity({
    required TransactionCategoryEntity categoryEntity,
  }) {
    return CategoryModel(
      id: categoryEntity.id,
      name: categoryEntity.name,
      iconPath: categoryEntity.iconPath,
      colorHex: categoryEntity.colorHex,
    );
  }

  TransactionCategoryEntity toEntity() {
    return TransactionCategoryEntity(
      id: id,
      name: name,
      iconPath: iconPath,
      colorHex: colorHex,
    );
  }
}
