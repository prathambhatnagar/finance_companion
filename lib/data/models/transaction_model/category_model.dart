import 'package:finance_companion/domain/entities/category_entity.dart';
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

  factory CategoryModel.fromEntity({required CategoryEntity categoryEntity}) {
    return CategoryModel(
      id: categoryEntity.id,
      name: categoryEntity.name,
      iconPath: categoryEntity.iconPath,
      colorHex: categoryEntity.colorHex,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      iconPath: iconPath,
      colorHex: colorHex,
    );
  }
}
