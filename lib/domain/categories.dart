class CategoriesResponse {
  bool? success;
  List<DataCategories>? data;
  String? message;

  CategoriesResponse({this.success, this.data, this.message});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataCategories>[];
      json['data'].forEach((v) {
        data!.add(new DataCategories.fromJson(v));
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

class DataCategories {
  int? id;
  String? name;

  DataCategories({this.id, this.name});

  DataCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}