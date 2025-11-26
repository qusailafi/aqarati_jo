
import '../controlers/payment/payment_response.dart';

class InvesmentResponse {
  bool? success;
  List<InvesmentsData>? data;
  String? message;

  InvesmentResponse({this.success, this.data, this.message});

  InvesmentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <InvesmentsData>[];
      json['data'].forEach((v) {
        data!.add(new InvesmentsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class InvesmentsData {
  int? id;
  int? sharesPurchased;
  double? totalAmount;
  int? propertyId;
  String? propertyTitle;
  String? propertyAddress;
  int? paymentMethodId;
  String? paymentMethod;
  int? paymentStatusId;
  String? paymentStatus;
  Null? cardLast4;
  String? createdAt;
  String? updatedAt;
  List<Transactions>? transactions;
  List<PropertyImages>? propertyImages;
  BankTransferInfo? bankTransferInfo;
String? paymentIntentClientSecret;
  InvesmentsData(
      {this.id,
        this.sharesPurchased,
        this.totalAmount,
        this.propertyId,
        this.propertyTitle,
        this.propertyAddress,
        this.paymentMethodId,
        this.paymentMethod,
        this.paymentStatusId,
        this.paymentStatus,
        this.cardLast4,
        this.createdAt,
        this.updatedAt,
        this.transactions,
        this.propertyImages,
        this.bankTransferInfo,this.paymentIntentClientSecret,});

  InvesmentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sharesPurchased = json['sharesPurchased'];
    totalAmount = json['totalAmount'];
    propertyId = json['propertyId'];
    propertyTitle = json['propertyTitle'];
    propertyAddress = json['propertyAddress'];
    paymentMethodId = json['paymentMethodId'];
    paymentMethod = json['paymentMethod'];
    paymentStatusId = json['paymentStatusId'];
    paymentStatus = json['paymentStatus'];
    cardLast4 = json['cardLast4'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    paymentIntentClientSecret=json['paymentIntentClientSecret'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    if (json['propertyImages'] != null) {
      propertyImages = <PropertyImages>[];
      json['propertyImages'].forEach((v) {
        propertyImages!.add(new PropertyImages.fromJson(v));
      });
    }
    bankTransferInfo = json['bankTransferInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sharesPurchased'] = this.sharesPurchased;
    data['totalAmount'] = this.totalAmount;
    data['propertyId'] = this.propertyId;
    data['propertyTitle'] = this.propertyTitle;
    data['propertyAddress'] = this.propertyAddress;
    data['paymentMethodId'] = this.paymentMethodId;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatusId'] = this.paymentStatusId;
    data['paymentStatus'] = this.paymentStatus;
    data['cardLast4'] = this.cardLast4;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.propertyImages != null) {
      data['propertyImages'] =
          this.propertyImages!.map((v) => v.toJson()).toList();
    }
    data['bankTransferInfo'] = this.bankTransferInfo;
    return data;
  }
}

class Transactions {
  int? paymentMethodId;
  String? paymentMethod;
  int? paymentStatusId;
  String? paymentStatus;
  Null? cardLast4;
  double? amount;
  String? createdAt;

  Transactions(
      {this.paymentMethodId,
        this.paymentMethod,
        this.paymentStatusId,
        this.paymentStatus,
        this.cardLast4,
        this.amount,
        this.createdAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['paymentMethodId'];
    paymentMethod = json['paymentMethod'];
    paymentStatusId = json['paymentStatusId'];
    paymentStatus = json['paymentStatus'];
    cardLast4 = json['cardLast4'];
    amount = json['amount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentMethodId'] = this.paymentMethodId;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatusId'] = this.paymentStatusId;
    data['paymentStatus'] = this.paymentStatus;
    data['cardLast4'] = this.cardLast4;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class PropertyImages {
  int? id;
  bool? isMain;
  int? order;
  String? imageUrl;

  PropertyImages({this.id, this.isMain, this.order, this.imageUrl});

  PropertyImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMain = json['isMain'];
    order = json['order'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isMain'] = this.isMain;
    data['order'] = this.order;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}