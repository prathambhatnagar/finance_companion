class TransactionCategoryEntity {
  final String id;
  final String name;
  final String iconPath;
  final int colorHex;

  const TransactionCategoryEntity({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.colorHex,
  });
}

final List<TransactionCategoryEntity> spendingCategories = [
  TransactionCategoryEntity(
    id: '1',
    name: 'Housing',
    iconPath: '',
    colorHex: 0xFFFF6B6B,
  ),
  TransactionCategoryEntity(
    id: '2',
    name: 'Utilities',
    iconPath: '',
    colorHex: 0xFF4ECDC4,
  ),
  TransactionCategoryEntity(
    id: '3',
    name: 'Groceries',
    iconPath: '',
    colorHex: 0xFF45B7D1,
  ),
  TransactionCategoryEntity(
    id: '4',
    name: 'Transportation',
    iconPath: '',
    colorHex: 0xFFFFA07A,
  ),
  TransactionCategoryEntity(
    id: '5',
    name: 'Entertainment',
    iconPath: '',
    colorHex: 0xFFC7CEEA,
  ),
  TransactionCategoryEntity(
    id: '6',
    name: 'Shopping',
    iconPath: '',
    colorHex: 0xFFFFB347,
  ),
  TransactionCategoryEntity(
    id: '7',
    name: 'Travel',
    iconPath: '',
    colorHex: 0xFF77DD77,
  ),
  TransactionCategoryEntity(
    id: '8',
    name: 'Health',
    iconPath: '',
    colorHex: 0xFFFF6961,
  ),
  TransactionCategoryEntity(
    id: '9',
    name: 'Education',
    iconPath: '',
    colorHex: 0xFFAEC6CF,
  ),
  TransactionCategoryEntity(
    id: '10',
    name: 'Savings',
    iconPath: '',
    colorHex: 0xFFFDFD96,
  ),
  TransactionCategoryEntity(
    id: '11',
    name: 'Miscellaneous',
    iconPath: '',
    colorHex: 0xFFB39EB5,
  ),
];
