class AllPropertiesResponse {
  bool? success;
  List<ProperitesData>? data;
  String? message;

  AllPropertiesResponse({this.success, this.data, this.message});

  AllPropertiesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProperitesData>[];
      json['data'].forEach((v) {
        data!.add(ProperitesData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ProperitesData {
  int? id;
  String? status;
  String? title;
  String? shortDescription;
  String? city;
  int? totalShares;
  int? sharesSold;
  double? pricePerShare;
  double? basePrice;
  double? taxesFees;
  double? progressPercentage;
  int? availableShares;
  double? totalInvestment;
  String? createdAt;
  String? propertyCondition;
  List<Images>? images;
  int? bathrooms;
  int? rooms;
  double? area;

  ProperitesData({
    this.id,
    this.status,
    this.title,
    this.shortDescription,
    this.city,
    this.totalShares,
    this.sharesSold,
    this.pricePerShare,
    this.basePrice,
    this.taxesFees,
    this.progressPercentage,
    this.availableShares,
    this.totalInvestment,
    this.createdAt,
    this.propertyCondition,
    this.images,
    this.bathrooms,
    this.rooms,
    this.area,
  });

  ProperitesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    city = json['city'];
    totalShares = json['totalShares'];
    sharesSold = json['sharesSold'];
    pricePerShare = _toDouble(json['pricePerShare']);
    basePrice = _toDouble(json['basePrice']);
    taxesFees = _toDouble(json['taxesFees']);
    progressPercentage = _toDouble(json['progressPercentage']);
    availableShares = json['availableShares'];
    totalInvestment = _toDouble(json['totalInvestment']);
    createdAt = json['createdAt'];
    propertyCondition = json['propertyCondition'];
    bathrooms = json['bathrooms'];
    rooms = json['rooms'];
    area = _toDouble(json['area']);
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['status'] = status;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    data['city'] = city;
    data['totalShares'] = totalShares;
    data['sharesSold'] = sharesSold;
    data['pricePerShare'] = pricePerShare;
    data['basePrice'] = basePrice;
    data['taxesFees'] = taxesFees;
    data['progressPercentage'] = progressPercentage;
    data['availableShares'] = availableShares;
    data['totalInvestment'] = totalInvestment;
    data['createdAt'] = createdAt;
    data['propertyCondition'] = propertyCondition;
    data['bathrooms'] = bathrooms;
    data['rooms'] = rooms;
    data['area'] = area;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// Helper to safely cast int → double
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return value as double?;
  }
}

class Images {
  int? id;
  bool? isMain;
  int? order;
  String? imageUrl;

  Images({this.id, this.isMain, this.order, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMain = json['isMain'];
    order = json['order'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['isMain'] = isMain;
    data['order'] = order;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
