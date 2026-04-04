import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(transaction.amount.toString())));
  }
}
