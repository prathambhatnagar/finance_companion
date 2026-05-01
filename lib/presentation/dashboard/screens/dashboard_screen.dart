import 'package:finance_companion/core/widgets/chart_widget/spending_categories.dart';
import 'package:finance_companion/presentation/dashboard/screens/add_transaction_screen.dart';
import 'package:finance_companion/presentation/dashboard/widgets/balance_carousel.dart';
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
              BalanceCarousel(),
              TransactionsContent(),
              SpendingCategories(),
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
