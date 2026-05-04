import 'dart:math';

import 'package:finance_companion/core/widgets/error_tile.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/core/widgets/shadow_container.dart';
import 'package:finance_companion/domain/usecases/transaction/get_spending_category_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpendingCategoryBarGraph extends StatelessWidget {
  const SpendingCategoryBarGraph({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (cotext, state) {
        if (state is TransactionLoadedState) {
          context.read<AccountBloc>().add(GetAccountsEvent());
        }
      },
      builder: (context, state) {
        if (state is TransactionLoadedState) {
          final transactions = state.transactions;
          final spendingCategories = getSpendingCategoryUsecase(transactions);
          if (transactions.isEmpty) return SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ShadowContainer(
              child: SizedBox(
                height: 260,
                child: BarChart(
                  BarChartData(
                    groupsSpace: 30,
                    backgroundColor: Colors.white,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: barChartRodDatas(spendingCategories),
                    maxY: 1000,
                    minY: 0,
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) => SizedBox.shrink(),
                          showTitles: true,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 50,
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              getTitles(value, meta, spendingCategories),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is TransactionLoadingState) {
          return const Loader();
        } else if (state is TransactionErrorState) {
          return ErrorTile(error: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  List<BarChartGroupData> barChartRodDatas(
    List<CategorySpending> transactions,
  ) {
    return transactions.asMap().entries.map((entry) {
      int index = entry.key;
      final tx = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(6),
            width: 20,
            toY: tx.total,
            color: Color(tx.colorHex),
            fromY: 0,
          ),
        ],
      );
    }).toList();
  }

  Widget getTitles(
    double value,
    TitleMeta meta,
    List<CategorySpending> spendingCategories,
  ) {
    final index = value.toInt();

    if (index < 0 || index >= spendingCategories.length) {
      return const SizedBox.shrink();
    }

    return SideTitleWidget(
      fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
      angle: -pi / 6,
      meta: meta,
      space: 10,
      child: SizedBox(
        width: 60,
        child: Text(
          spendingCategories[index].category,
          style: const TextStyle(fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
