import 'package:finance_companion/core/utility/currency_format.dart';
import 'package:finance_companion/core/widgets/shadow_container.dart';
import 'package:finance_companion/domain/usecases/transaction/predict_total_monthly_spending_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictMonthlySpendingTile extends StatelessWidget {
  const PredictMonthlySpendingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadedState) {
          final predictedMonthlySpending = predictTotalMonthlySpendingUsecase(
            state.transactions,
            DateTime.now(),
          );
          return ShadowContainer(
            child: ListTile(
              title: Text(
                'At this pace you will \$: ${format.format(predictedMonthlySpending)} by this end of this month',
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
