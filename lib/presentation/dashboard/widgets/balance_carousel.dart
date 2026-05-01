import 'package:finance_companion/core/widgets/error_tile.dart';
import 'package:finance_companion/core/widgets/loader.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_state.dart';
import 'package:finance_companion/presentation/dashboard/widgets/current_balance_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceCarousel extends StatelessWidget {
  const BalanceCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadingState) {
            return Loader();
          } else if (state is AccountErrorgState) {
            return ErrorTile(error: state.message);
          } else if (state is AccountLoadedState) {
            return PageView.builder(
              itemCount: state.accounts.length,
              controller: PageController(),
              itemBuilder: (context, index) {
                return CurrentBalanceCard(account: state.accounts[index]);
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
