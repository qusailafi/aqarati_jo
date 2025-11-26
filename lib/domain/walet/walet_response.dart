class WaletResponse {
  bool success;
  List<WaletData> data;
  String message;

  WaletResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory WaletResponse.fromJson(Map<String, dynamic> json) => WaletResponse(
    success: json["success"],
    data: List<WaletData>.from(json["data"].map((x) => WaletData.fromJson(x))),
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class WaletData {
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
  List<Transaction> transactions;
  List<PropertyImage> propertyImages;
  BankTransferInfo? bankTransferInfo;

  WaletData({
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
    this.bankTransferInfo,
  });

  factory WaletData.fromJson(Map<String, dynamic> json) => WaletData(
    id: json["id"],
    sharesPurchased: json["sharesPurchased"],
    totalAmount: (json["totalAmount"] as num).toDouble(),
    propertyId: json["propertyId"],
    propertyTitle: json["propertyTitle"],
    propertyAddress: json["propertyAddress"],
    paymentMethodId: json["paymentMethodId"],
    paymentMethod: json["paymentMethod"],
    paymentStatusId: json["paymentStatusId"],
    paymentStatus: json["paymentStatus"],
    cardLast4: json["cardLast4"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    transactions: json["transactions"] != null
        ? List<Transaction>.from(
        json["transactions"].map((x) => Transaction.fromJson(x)))
        : [],
    propertyImages: json["propertyImages"] != null
        ? List<PropertyImage>.from(
        json["propertyImages"].map((x) => PropertyImage.fromJson(x)))
        : [],
    bankTransferInfo: json["bankTransferInfo"] != null
        ? BankTransferInfo.fromJson(json["bankTransferInfo"])
        : null,
  );

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
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "propertyImages":
    List<dynamic>.from(propertyImages.map((x) => x.toJson())),
    "bankTransferInfo": bankTransferInfo?.toJson(),
  };
}

class Transaction {
  int paymentMethodId;
  String paymentMethod;
  int paymentStatusId;
  String paymentStatus;
  String? cardLast4;
  double amount;
  DateTime createdAt;

  Transaction({
    required this.paymentMethodId,
    required this.paymentMethod,
    required this.paymentStatusId,
    required this.paymentStatus,
    this.cardLast4,
    required this.amount,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    paymentMethodId: json["paymentMethodId"],
    paymentMethod: json["paymentMethod"],
    paymentStatusId: json["paymentStatusId"],
    paymentStatus: json["paymentStatus"],
    cardLast4: json["cardLast4"],
    amount: (json["amount"] as num).toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentMethodId": paymentMethodId,
    "paymentMethod": paymentMethod,
    "paymentStatusId": paymentStatusId,
    "paymentStatus": paymentStatus,
    "cardLast4": cardLast4,
    "amount": amount,
    "createdAt": createdAt.toIso8601String(),
  };
}

class PropertyImage {
  int id;
  bool isMain;
  int order;
  String imageUrl;

  PropertyImage({
    required this.id,
    required this.isMain,
    required this.order,
    required this.imageUrl,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
    id: json["id"],
    isMain: json["isMain"],
    order: json["order"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isMain": isMain,
    "order": order,
    "imageUrl": imageUrl,
  };
}

class BankTransferInfo {
  String iban;
  String bankName;
  String accountName;
  double amount;
  String investmentId;
  String ?notes;
  String ?swiftCode;
  BankTransferInfo({
    required this.iban,
    required this.bankName,
    required this.accountName,
    required this.amount,
    required this.investmentId,
    this.notes,this.swiftCode
  });

  factory BankTransferInfo.fromJson(Map<String, dynamic> json) =>
      BankTransferInfo(
        iban: json["iban"],
        bankName: json["bankName"],
        accountName: json["accountName"],
        amount: (json["amount"] as num).toDouble(),
        investmentId: json["investmentId"],
        notes:json["notes"],
        swiftCode: json["swiftCode"]
      );

  Map<String, dynamic> toJson() => {
    "iban": iban,
    "bankName": bankName,
    "accountName": accountName,
    "amount": amount,
    "investmentId": investmentId,
  };
}
