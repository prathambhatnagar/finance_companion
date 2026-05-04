import 'package:finance_companion/core/widgets/error_tile.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/core/widgets/shadow_container.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_state.dart';
import 'package:finance_companion/presentation/dashboard/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsContent extends StatefulWidget {
  const TransactionsContent({super.key});

  @override
  State<TransactionsContent> createState() => _TransactionsContentState();
}

class _TransactionsContentState extends State<TransactionsContent> {
  ValueNotifier<bool> showAll = ValueNotifier<bool>(false);

  @override
  void dispose() {
    showAll.dispose();
    super.dispose();
  }

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
                    ValueListenableBuilder(
                      valueListenable: showAll,
                      builder: (context, value, child) {
                        return TextButton(
                          child: Text(
                            showAll.value ? 'Show less' : 'Show more',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => showAll.value = !showAll.value,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ValueListenableBuilder(
                  valueListenable: showAll,
                  builder: (context, state, child) {
                    return ShadowContainer(
                      child: AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transactions.length < 5 || showAll.value
                              ? transactions.length
                              : 5,
                          itemBuilder: (context, index) =>
                              TransactionTile(transaction: transactions[index]),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Divider(
                              height: 0,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
