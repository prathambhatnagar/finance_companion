import 'package:finance_companion/presentation/dashboard/widgets/current_balance_tile.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CurrentBalanceTile(),
          ListView.builder(itemBuilder: itemBuilder),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
