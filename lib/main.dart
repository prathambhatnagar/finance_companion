import 'package:finance_companion/core/service_locator.dart/service_locator.dart';
import 'package:finance_companion/data/models/account_model/account_model.dart';
import 'package:finance_companion/data/models/transaction_model/category_model.dart';
import 'package:finance_companion/data/models/transaction_model/transaction_model.dart';
import 'package:finance_companion/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/add_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/delete_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/account_bloc/account_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_bloc/transaction_event.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc(
            getAllTransactionUsecase:
                serviceLocator<GetAllTransactionUsecase>(),
            addTransactionUsecase: serviceLocator<AddTransactionUsecase>(),
            deleteTransactionUsecase:
                serviceLocator<DeleteTransactionUsecase>(),
          )..add(GetAllTransactionEvent()),
        ),

        BlocProvider(
          create: (context) => AccountBloc(
            getAccountsUsecase: serviceLocator<GetAccountsUsecase>(),
          )..add(GetAccountsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardScreen(),
      ),
    );
  }
}

Future<void> init() async {
  await Hive.initFlutter();
  await serviceLocatorInit();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(AccountModelAdapter());
  await Hive.openBox('transactions_box');
  await Hive.openBox('account_box');

  final box = await Hive.openBox('account_box');

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

// Low Balance Alert
// Most Spending category  bargraph
// Top Spending Categories
// Largest Transaction
// Daily / Weekly Average Spending
// Recurring Expenses (subscriptions, rent)
// Overspending Alerts
// Budget vs Actual Spending
// “You spent 20% more on food this month”
// auto pay / Subscription reminders
// Income vs Expenses
// Monthly Summary (this month vs last month)
// Budget usage (e.g., 70% spent)
