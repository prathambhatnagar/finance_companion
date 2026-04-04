abstract class Failure {
  Failure({required this.message});
  String message;
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({required super.message});
}
