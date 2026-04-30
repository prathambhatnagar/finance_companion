import 'dart:developer';

import 'package:finance_companion/data/models/account_model/account_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class LocalAccountService {
  Future<List<AccountModel>> getAccounts();

  Future<AccountModel> getAccountById(String id);

  Future<void> updateAccountBalance({
    required String id,
    required double newBalance,
  });

  Future<void> seedDefaultAccounts();
}

class LocalAccountServiceImpl extends LocalAccountService {
  final _boxName = 'account_box';

  @override
  Future<List<AccountModel>> getAccounts() async {
    final box = Hive.box(_boxName);
    return box.values.cast<AccountModel>().toList();
  }

  @override
  Future<AccountModel> getAccountById(String id) async {
    final box = Hive.box(_boxName);
    final account = box.get(id);
    return account;
  }

  @override
  Future<void> updateAccountBalance({
    required String id,
    required double newBalance,
  }) async {
    final box = Hive.box(_boxName);
    final account = box.get(id);
    if (account != null) {
      log(
        "id: ${account.id}\n name: ${account.name}\n balance: $newBalance \n colorHex: ${account.colorHex}\n previous: ${account.balance}",
      );
      final updatedAccount = AccountModel(
        id: account.id,
        name: account.name,
        balance: newBalance,
        colorHex: account.colorHex,
        previous: account.balance,
      );

      await box.put(id, updatedAccount);
    }
  }

  @override
  Future<void> seedDefaultAccounts() async {
    final box = await Hive.openBox(_boxName);

    if (box.isEmpty) {
      await box.putAll({
        'cash': AccountModel(
          id: 'cash',
          name: 'cash',
          balance: 0.0,
          colorHex: '0xFF4CAF50',
        ),
        'savings': AccountModel(
          id: 'savings',
          name: 'Savings',
          balance: 0.0,
          colorHex: '0xFF2196F3',
        ),
        'card': AccountModel(
          id: 'card',
          name: 'Card',
          balance: 0.0,
          colorHex: '0xFFF44336',
        ),
      });
    }
  }
}
