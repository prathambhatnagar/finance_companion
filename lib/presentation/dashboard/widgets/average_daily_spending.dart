import 'package:finance_companion/core/utility/currency_format.dart';
import 'package:finance_companion/core/widgets/shadow_container.dart';
import 'package:finance_companion/domain/usecases/transaction/get_avg_daily_spending_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AverageDailySpending extends StatelessWidget {
  const AverageDailySpending({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadedState) {
          final predictedMonthlySpending = getAvgDailySpendingUsecase(
            state.transactions,
            DateTime.now(),
          );
          return ShadowContainer(
            child: ListTile(
              title: Text(
                ' Average Spend per Day\$: ${format.format(predictedMonthlySpending)}',
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
