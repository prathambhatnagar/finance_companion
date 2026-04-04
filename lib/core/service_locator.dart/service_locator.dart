import 'package:finance_companion/data/repositories/transaction/transaction_repo_impl.dart';
import 'package:finance_companion/data/services/transactions_service/transactions_local_service.dart';
import 'package:finance_companion/domain/repositories/transaction/transaction_repo.dart';
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

  serviceLocator.registerSingleton<AddTransactionUsecase>(
    AddTransactionUsecase(transactionRepo: serviceLocator<TransactionRepo>()),
  );

  serviceLocator.registerSingleton<DeleteTransactionUsecase>(
    DeleteTransactionUsecase(
      transactionRepo: serviceLocator<TransactionRepo>(),
    ),
  );
}
