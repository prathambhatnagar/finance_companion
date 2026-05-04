import 'package:finance_companion/core/widgets/chart_widget/spending_category_bar.dart';
import 'package:finance_companion/presentation/dashboard/screens/add_transaction_screen.dart';
import 'package:finance_companion/presentation/dashboard/widgets/average_daily_spending.dart';
import 'package:finance_companion/presentation/dashboard/widgets/balance_carousel.dart';
import 'package:finance_companion/presentation/dashboard/widgets/predict_monthly_spending_tile.dart';
import 'package:finance_companion/presentation/dashboard/widgets/predicted_month_end_balance.dart';
import 'package:finance_companion/presentation/dashboard/widgets/transactions_content.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PredictedMonthEndBalance(),
              AverageDailySpending(),
              PredictMonthlySpendingTile(),
              BalanceCarousel(),
              TransactionsContent(),
              SizedBox(height: 12),
              SpendingCategoryBarGraph(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
      ),
    );
  }
}
