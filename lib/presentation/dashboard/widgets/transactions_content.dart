import 'package:finance_companion/core/widgets/error_tile.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_state.dart';
import 'package:finance_companion/presentation/dashboard/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsContent extends StatelessWidget {
  const TransactionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadedState) {
          final transactions = state.transactionsList;
          if (transactions.isEmpty) return EmptyTransaction();
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) =>
                  TransactionTile(transaction: transactions[index]),
            ),
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
}

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Icon(Icons.import_contacts), Text('No Transactions Found')],
      ),
    );
  }
}
