import 'package:finance_companion/core/widgets/error_tile.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_state.dart';
import 'package:finance_companion/presentation/dashboard/widgets/transactions_content.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpendingCategories extends StatelessWidget {
  const SpendingCategories({super.key});

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
          final transactions = state.transactionsList;
          barChartRodDatas(transactions);

          if (transactions.isEmpty) return EmptyTransaction();
          return Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      child: Text('Show all', style: TextStyle(fontSize: 16)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(width: 2, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    height: 220,
                    child: BarChart(
                      BarChartData(
                        groupsSpace: 20,
                        backgroundColor: Colors.white,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: barChartRodDatas(transactions),
                        maxY: 1000,
                        minY: 0,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) =>
                                  Text(value.toString()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is TransactionLoadingState) {
          return Loader();
        } else if (state is TransactionErrorState) {
          return ErrorTile(error: state.message);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  List<BarChartGroupData> barChartRodDatas(
    List<TransactionEntity> transactions,
  ) {
    Map<String, Map<String, dynamic>> txData = {};
    transactions.map((tx) {
      final category = tx.category?.name ?? 'un-categorized';
      final amount = tx.amount;
      final color = Color(tx.category?.colorHex ?? 0xFF9E9E9E);

      if (txData.containsKey(category)) {
        txData[category]!['total'] += amount;
      } else {
        txData[category] = {'total': amount, 'color': color};
      }
    }).toList();

    return txData.keys.map((e) {
      return BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.circular(6),
            width: 20,
            toY: txData[e]!['total'],
            color: txData[e.toString()]!['color'],
            fromY: 0,
          ),
        ],
      );
    }).toList();
  }
}
