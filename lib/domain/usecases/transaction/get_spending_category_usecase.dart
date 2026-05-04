import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';

List<CategorySpending> getSpendingCategoryUsecase(
  List<TransactionEntity> transactions,
) {
  Map<String, Map<String, dynamic>> txData = {};
  transactions.map((tx) {
    if (tx.type == TransactionTypeEntity.income) return;
    final category = tx.category?.name ?? 'un-categorized';
    final amount = tx.amount;
    final color = tx.category?.colorHex ?? 0xFF9E9E9E;

    if (txData.containsKey(category)) {
      txData[category]!['total'] += amount;
    } else {
      txData[category] = {'total': amount, 'color': color};
    }
  }).toList();

  return txData.keys.map((e) {
    return CategorySpending(
      category: e,
      total: txData[e]!['total'],
      colorHex: txData[e.toString()]!['color'],
    );
  }).toList();
}

class CategorySpending {
  CategorySpending({
    required this.category,
    required this.colorHex,
    required this.total,
  });
  final String category;
  final double total;
  final int colorHex;
}
