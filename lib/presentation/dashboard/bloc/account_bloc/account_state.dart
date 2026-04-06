import 'package:finance_companion/domain/entities/account/account_entity.dart';

abstract class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  AccountLoadedState({required this.accounts});
  final List<AccountEntity> accounts;
}

class AccountErrorgState extends AccountState {
  AccountErrorgState({required this.message});
  String message;
}
