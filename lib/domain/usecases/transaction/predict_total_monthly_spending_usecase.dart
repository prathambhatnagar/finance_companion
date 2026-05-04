import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/domain/usecases/transaction/get_avg_daily_spending_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_total_monthly_spending_usecase.dart';
import 'package:flutter/material.dart';

double predictTotalMonthlySpendingUsecase(
  List<TransactionEntity> transactions,
  DateTime dateTime,
) {
  final spendSoFar = getTotalMonthlySpendingUsecase(transactions, dateTime);
  final dailyAverage = getAvgDailySpendingUsecase(transactions, dateTime);
  final daysLeft =
      DateUtils.getDaysInMonth(dateTime.year, dateTime.month) - dateTime.day;

  return spendSoFar + (dailyAverage * daysLeft);
}
