import 'package:finance_companion/core/utility/currency_format.dart';
import 'package:finance_companion/core/widgets/shadow_container.dart';
import 'package:finance_companion/presentation/dashboard/bloc/dashboard_cubit/dashboard_cubit.dart';
import 'package:finance_companion/presentation/dashboard/bloc/dashboard_cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictedMonthEndBalance extends StatelessWidget {
  const PredictedMonthEndBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.isLoading && state.error == null) {
          return ShadowContainer(
            child: ListTile(title: Text("Predicting Your month End Balance")),
          );
        } else if (!state.isLoading && state.error == null) {
          return ShadowContainer(
            child: ListTile(
              title: Text(
                "At this pace you will have : ${format.format(state.predictionResult)} by the end of the month ",
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
