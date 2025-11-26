class BlocksResponse {
  bool? success;
  List<Data>? data;

  BlocksResponse({this.success, this.data});

  BlocksResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? bricks;
  int? shares;
  double? totalPrice;

  Data({this.bricks, this.shares, this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    bricks = json['bricks'];
    shares = json['shares'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bricks'] = this.bricks;
    data['shares'] = this.shares;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}