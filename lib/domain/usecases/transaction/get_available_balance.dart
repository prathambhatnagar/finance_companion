import 'package:finance_companion/domain/entities/account/account_entity.dart';

double getAvailableBalance({required List<AccountEntity> accounts}) {
  double sum = 0;
  for (int i = 0; i < accounts.length; i++) {
    sum += accounts[i].balance;
  }
  return sum;
}
