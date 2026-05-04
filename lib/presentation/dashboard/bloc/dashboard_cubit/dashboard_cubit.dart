import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_available_balance.dart';
import 'package:finance_companion/domain/usecases/transaction/predict_month_end_balance_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/predict_total_monthly_spending_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/dashboard_cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.getAccountsUsecase,
    required this.getAllTransactionUsecase,
  }) : super(DashboardState(predictionResult: 0, total: 0, isLoading: true));
  final GetAccountsUsecase getAccountsUsecase;
  final GetAllTransactionUsecase getAllTransactionUsecase;

  void predictMonthEndBalance() async {
    emit(DashboardState(predictionResult: 0, total: 0, isLoading: true));
    final accountResult = await getAccountsUsecase.call(param: NoParam());
    final transactionsResult = await getAllTransactionUsecase.call(
      param: NoParam(),
    );

    accountResult.fold(
      (accountError) => emit(
        DashboardState(
          predictionResult: 0,
          total: 0,
          error: accountError.message,
        ),
      ),
      (accounts) {
        transactionsResult.fold(
          (transactionError) => emit(
            DashboardState(
              predictionResult: 0,
              total: 0,
              error: transactionError.message,
            ),
          ),
          (transactions) {
            final availableBalance = getAvailableBalance(accounts: accounts);
            final predictedMonthlySpending = predictTotalMonthlySpendingUsecase(
              transactions,
              DateTime.now(),
            );
            final predictedMonthlyEndBalance = predictMonthEndBalanceUsecase(
              availableBalance: availableBalance,
              predictedMonthlySpending: predictedMonthlySpending,
            );
            emit(
              state.copyWith(
                total: availableBalance,
                predictionResult: predictedMonthlyEndBalance,
                isLoading: false,
                error: null,
              ),
            );
          },
        );
      },
    );
  }
}
