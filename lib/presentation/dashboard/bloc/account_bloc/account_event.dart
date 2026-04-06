abstract class AccountEvent {}

class GetAccountsEvent extends AccountEvent {}

class GetAccountEvent extends AccountEvent {
  GetAccountEvent({required this.id});
  String id;
}

class UpdateAccountEvent extends AccountEvent {
  UpdateAccountEvent({required this.id, required this.newBalance});
  String id;
  double newBalance;
}
