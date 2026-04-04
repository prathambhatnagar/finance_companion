import 'package:finance_companion/core/service_locator.dart/service_locator.dart';
import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:finance_companion/domain/usecases/transaction/add_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/delete_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        getAllTransactionUsecase: serviceLocator<GetAllTransactionUsecase>(),
        addTransactionUsecase: serviceLocator<AddTransactionUsecase>(),
        deleteTransactionUsecase: serviceLocator<DeleteTransactionUsecase>(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardScreen(),
      ),
    );
  }
}

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.openBox('transactions_box');
}
