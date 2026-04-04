import 'package:finance_companion/presentation/dashboard/screens/add_transaction_screen.dart';
import 'package:finance_companion/presentation/dashboard/widgets/current_balance_tile.dart';
import 'package:finance_companion/presentation/dashboard/widgets/transactions_content.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [CurrentBalanceTile(), TransactionsContent()]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
          // context.read<TransactionBloc>().add(
          //   AddTransactionEvent(
          //     transaction: TransactionEntity(
          //       id: DateTime.now().millisecondsSinceEpoch.toString(),
          //       note: 'test',
          //       amount: 8500.0,
          //       type: TransactionTypeEntity.credit,
          //       timeStamp: DateTime.now(),
          //       category: TransactionCategoryEntity(
          //         id: '1',
          //         name: 'Food',
          //         iconPath: '',
          //         colorHex: 14,
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
