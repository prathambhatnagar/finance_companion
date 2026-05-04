import 'package:finance_companion/core/utility/currency_format.dart';
import 'package:finance_companion/domain/entities/transaction/transaction_entity.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionTypeEntity.income;
    ValueNotifier<bool> showDelete = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: showDelete,
      builder: (context, value, child) {
        return AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () => showDelete.value = false,
            onLongPress: () => showDelete.value = true,
            child: Column(
              children: [
                ListTile(
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),

                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (transaction.note.isNotEmpty) ...[
                        Text(
                          transaction.note,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),

                        const SizedBox(width: 8),
                        Icon(Icons.circle, size: 8, color: Colors.grey),
                        const SizedBox(width: 8),
                      ],

                      Text(
                        _formatDate(transaction.timeStamp),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isIncome ? '+' : '-'} ₹${format.format(transaction.amount)}',
                        style: TextStyle(
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.account.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showDelete.value) ...[
                  GestureDetector(
                    onTap: () {
                      context.read<TransactionBloc>().add(
                        DeleteTransactionEvent(transaction: transaction),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Delete Transaction',
                              style: TextStyle(fontSize: 16, letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
