import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionTypeEntity.income;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: transaction.category != null
              ? Color(transaction.category!.colorHex)
              : Colors.grey.shade400,
          child: Text(
            transaction.category?.name.substring(0, 1) ?? '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          transaction.category?.name ?? 'No Category',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),

        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (transaction.note.isNotEmpty)
              Text(
                transaction.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              ),

            const SizedBox(width: 8),
            Icon(Icons.circle, size: 8, color: Colors.grey),
            const SizedBox(width: 8),

            Text(
              _formatDate(transaction.timeStamp),
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              transaction.account.name,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
