import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';

double getTotalMonthlySpendingUsecase(
  List<TransactionEntity> transactions,
  DateTime dateTime,
) {
  double total = 0;

  for (int i = 0; i < transactions.length; i++) {
    final tx = transactions[i];

    if (tx.type == TransactionTypeEntity.expense &&
        tx.timeStamp.month == dateTime.month &&
        tx.timeStamp.year == dateTime.year) {
      total += tx.amount;
    }
  }

  return total;
}
