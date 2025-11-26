class BankAccount {
  final String iban;
  final String bankName;
  final String accountName;
  final double amount;
  final String investmentId;
  final String notes;
  final String swiftCode;

  BankAccount({
    required this.iban,
    required this.bankName,
    required this.accountName,
    required this.amount,
    required this.investmentId,
    required this.notes,
    required this.swiftCode,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      iban: json['iban'] ?? '',
      bankName: json['bankName'] ?? '',
      accountName: json['accountName'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      investmentId: json['investmentId'] ?? '',
      notes: json['notes'] ?? '',
      swiftCode: json['swiftCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iban': iban,
      'bankName': bankName,
      'accountName': accountName,
      'amount': amount,
      'investmentId': investmentId,
      'notes': notes,
      'swiftCode': swiftCode,
    };
  }
}
