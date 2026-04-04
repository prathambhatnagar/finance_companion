class AccountEntity {
  const AccountEntity({
    required this.id,
    required this.name,
    required this.balance,
    required this.colorHex,
  });

  final String id;
  final String name;
  final double balance;
  final String colorHex;
}
