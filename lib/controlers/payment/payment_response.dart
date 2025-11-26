class PaymentReponse {
  bool success;
  PaymentData data;
  String message;

  PaymentReponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PaymentReponse.fromJson(Map<String, dynamic> json) => PaymentReponse(
    success: json["success"],
    data: PaymentData.fromJson(json["data"]),
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class PaymentData {
  int id;
  int sharesPurchased;
  double totalAmount;
  int propertyId;
  String propertyTitle;
  String propertyAddress;
  int paymentMethodId;
  String paymentMethod;
  int paymentStatusId;
  String paymentStatus;
  String? cardLast4;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> transactions;
  List<dynamic> propertyImages;
  String paymentIntentClientSecret;
  final List<BankTransferInfo> bankTransferInfoList;

  PaymentData({
    required this.id,
    required this.sharesPurchased,
    required this.totalAmount,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyAddress,
    required this.paymentMethodId,
    required this.paymentMethod,
    required this.paymentStatusId,
    required this.paymentStatus,
    this.cardLast4,
    required this.createdAt,
    required this.updatedAt,
    required this.transactions,
    required this.propertyImages,
    required this.bankTransferInfoList,
 required   this
  .paymentIntentClientSecret
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    sharesPurchased: json["sharesPurchased"],
    totalAmount: (json["totalAmount"] as num).toDouble(),
    propertyId: json["propertyId"],
    propertyTitle: json["propertyTitle"],
    propertyAddress: json["propertyAddress"],
    paymentMethodId: json["paymentMethodId"],
    paymentMethod: json["paymentMethod"],
    paymentStatusId: json["paymentStatusId"],
    paymentIntentClientSecret:json["paymentIntentClientSecret"]??"",
    paymentStatus: json["paymentStatus"],
    cardLast4: json["cardLast4"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    transactions: json["transactions"] ?? [],
    propertyImages: json["propertyImages"] ?? [],
    bankTransferInfoList:
    (json['bankTransferInfoList'] as List<dynamic>?)
        ?.map((e) =>
        BankTransferInfo.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sharesPurchased": sharesPurchased,
    "totalAmount": totalAmount,
    "propertyId": propertyId,
    "propertyTitle": propertyTitle,
    "propertyAddress": propertyAddress,
    "paymentMethodId": paymentMethodId,
    "paymentMethod": paymentMethod,
    "paymentStatusId": paymentStatusId,
    "paymentStatus": paymentStatus,
    "cardLast4": cardLast4,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "transactions": transactions,
    "propertyImages": propertyImages,
    'bankTransferInfoList':
    bankTransferInfoList.map((e) => e.toJson()).toList(),  };
}

class BankTransferInfo {
  final String iban;
  final String bankName;
  final String accountName;
  final double amount;
  final String investmentId;
  final String notes;
  final String swiftCode;

  BankTransferInfo({
    required this.iban,
    required this.bankName,
    required this.accountName,
    required this.amount,
    required this.investmentId,
    required this.notes,
    required this.swiftCode,
  });

  factory BankTransferInfo.fromJson(Map<String, dynamic> json) {
    return BankTransferInfo(
      iban: json['iban'] ?? '',
      bankName: json['bankName'] ?? '',
      accountName: json['accountName'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      investmentId: json['investmentId']?.toString() ?? '',
      notes: json['notes'] ?? '',
      swiftCode: json['swiftCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'iban': iban,
    'bankName': bankName,
    'accountName': accountName,
    'amount': amount,
    'investmentId': investmentId,
    'notes': notes,
    'swiftCode': swiftCode,
  };
}