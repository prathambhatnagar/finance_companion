import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: );
  }
}

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.openBox('transactions_box');
}
