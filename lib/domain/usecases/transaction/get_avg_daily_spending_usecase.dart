import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/domain/usecases/transaction/get_total_monthly_spending_usecase.dart';

double getAvgDailySpendingUsecase(
  List<TransactionEntity> transactions,
  DateTime dateTime,
) {
  final total = getTotalMonthlySpendingUsecase(transactions, dateTime);
  final daysGone = dateTime.day;
  if (daysGone == 0) return 0;
  return total / daysGone;
}
