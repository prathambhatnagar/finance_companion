import 'package:finance_companion/core/usecase/usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/add_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/delete_transaction_usecase.dart';
import 'package:finance_companion/domain/usecases/transaction/get_all_transaction_usecase.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_event.dart';
import 'package:finance_companion/presentation/dashboard/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    required this.getAllTransactionUsecase,
    required this.addTransactionUsecase,
    required this.deleteTransactionUsecase,
  }) : super(TransactionLoadingState()) {
    on<GetAllTransactionEvent>(
      (event, emit) => _onGetAllTransactionEvent(event, emit),
    );

    on<AddTransactionEvent>(
      (event, emit) => _onAddTransactionEvent(event, emit),
    );

    on<DeleteTransactionEvent>(
      (event, emit) => _onDeleteTransactionEvent(event, emit),
    );
  }

  GetAllTransactionUsecase getAllTransactionUsecase;
  AddTransactionUsecase addTransactionUsecase;
  DeleteTransactionUsecase deleteTransactionUsecase;

  Future<void> _onGetAllTransactionEvent(
    GetAllTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final result = await getAllTransactionUsecase.call(param: NoParam());
    result.fold(
      (failure) {
        emit(TransactionErrorState(message: failure.message));
      },
      (transactionsList) {
        emit(TransactionLoadedState(transactionsList: transactionsList));
      },
    );
  }

  Future<void> _onAddTransactionEvent(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final result = await addTransactionUsecase.call(
      param: AddTransactionPram(
        id: event.transactionId,
        transaction: event.transaction,
      ),
    );
    result.fold((failure) {
      emit(TransactionErrorState(message: failure.message));
    }, (_) => add(GetAllTransactionEvent()));
  }

  Future<void> _onDeleteTransactionEvent(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final result = await deleteTransactionUsecase.call(
      param: event.transactionId,
    );
    result.fold((failure) {
      emit(TransactionErrorState(message: failure.message));
    }, (_) => add(GetAllTransactionEvent()));
  }
}
