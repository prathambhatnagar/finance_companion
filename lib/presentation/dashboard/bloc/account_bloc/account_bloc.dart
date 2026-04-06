import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.getAccountsUsecase})
    : super(AccountLoadingState()) {
    on<GetAccountsEvent>(_onGetAccountsEvent);
  }
  GetAccountsUsecase getAccountsUsecase;

  Future<void> _onGetAccountsEvent(
    GetAccountsEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoadingState());
    final result = await getAccountsUsecase.call(param: NoParam());

    result.fold(
      (failure) => emit(AccountErrorgState(message: failure.message)),
      (accounts) => emit(AccountLoadedState(accounts: accounts)),
    );
  }
}
