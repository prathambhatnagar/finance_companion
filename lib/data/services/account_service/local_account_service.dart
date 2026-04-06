import 'dart:developer';

import 'package:finance_companion/core/utility/id_generator.dart';
import 'package:finance_companion/data/models/account_model/account_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class LocalAccountService {
  Future<List<AccountModel>> getAccounts();

  Future<AccountModel> getAccountById(String id);

  Future<void> updateAccountBalance({
    required String id,
    required double newBalance,
    required double previousBalance,
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
    return account!;
  }

  @override
  Future<void> updateAccountBalance({
    required String id,
    required double newBalance,
    required double previousBalance,
  }) async {
    final box = Hive.box(_boxName);
    final account = box.get(id);
    if (account != null) {
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
      log("box is empty");
      await box.addAll([
        AccountModel(
          id: generateId(),
          name: 'cash',
          balance: 0.0,
          colorHex: '0xFF4CAF50',
        ),
        AccountModel(
          id: generateId(),
          name: 'Savings',
          balance: 0.0,
          colorHex: '0xFF2196F3',
        ),
        AccountModel(
          id: generateId(),
          name: 'Card',
          balance: 0.0,
          colorHex: '0xFFF44336',
        ),
      ]);
    }
  }
}
