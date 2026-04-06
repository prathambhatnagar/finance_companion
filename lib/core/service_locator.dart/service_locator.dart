import 'package:finance_companion/data/repositories/account/account_repo_impl.dart';
import 'package:finance_companion/data/repositories/transaction/transaction_repo_impl.dart';
import 'package:finance_companion/data/services/account_service/local_account_service.dart';
import 'package:finance_companion/data/services/transactions_service/local_transactions_service.dart';
import 'package:finance_companion/domain/repositories/account_repo/account_repo.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';
import 'package:finance_companion/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/add_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/delete_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Transactions
  serviceLocator.registerSingleton<TransactionLocalService>(
    TransactionLocalServiceImpl(),
  );

  serviceLocator.registerSingleton<TransactionRepo>(
    TransactionRepoImpl(
      transactionsLocalService: serviceLocator<TransactionLocalService>(),
    ),
  );

  serviceLocator.registerSingleton<GetAllTransactionUsecase>(
    GetAllTransactionUsecase(
      transactionRepo: serviceLocator<TransactionRepo>(),
    ),
  );

  // Account repo
  serviceLocator.registerSingleton<LocalAccountService>(
    LocalAccountServiceImpl(),
  );

  serviceLocator.registerSingleton<AccountRepo>(
    AccountRepoImpl(localAccountService: serviceLocator<LocalAccountService>()),
  );

  serviceLocator.registerSingleton<AddTransactionUsecase>(
    AddTransactionUsecase(
      transactionRepo: serviceLocator<TransactionRepo>(),
      accountRepo: serviceLocator<AccountRepo>(),
    ),
  );

  serviceLocator.registerSingleton<DeleteTransactionUsecase>(
    DeleteTransactionUsecase(
      transactionRepo: serviceLocator<TransactionRepo>(),
      accountRepo: serviceLocator<AccountRepo>(),
    ),
  );

  serviceLocator.registerSingleton<GetAccountsUsecase>(
    GetAccountsUsecase(accountRepo: serviceLocator<AccountRepo>()),
  );
}
