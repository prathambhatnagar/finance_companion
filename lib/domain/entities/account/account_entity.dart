class AccountEntity {
  const AccountEntity({
    required this.id,
    required this.name,
    required this.balance,
    this.previous,
    required this.colorHex,
  });

  final String id;
  final String name;
  final double balance;
  final double? previous;
  final String colorHex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
