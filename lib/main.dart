import 'package:finance_companion/core/service_locator.dart/service_locator.dart';
import 'package:finance_companion/data/models/transaction_model/category_model.dart';
import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:finance_companion/domain/usecases/transaction/add_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/delete_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_event.dart';
import 'package:finance_companion/presentation/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
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
      )..add(GetAllTransactionEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardScreen(),
      ),
    );
  }
}

Future<void> init() async {
  await serviceLocatorInit();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox('transactions_box');
}
