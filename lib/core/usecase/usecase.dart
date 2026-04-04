import 'package:dartz/dartz.dart';
import 'package:finance_companion/core/error/failure.dart';

abstract class Usecase<ReturnType, Param> {
  Future<Either<Failure, ReturnType>> call({required Param param});
}

class NoParam {}
