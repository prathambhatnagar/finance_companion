double predictMonthEndBalanceUsecase({
  required double availableBalance,
  required double predictedMonthlySpending,
}) {
  return availableBalance - predictedMonthlySpending;
}
