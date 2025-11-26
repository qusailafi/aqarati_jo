class UserProfileResponse {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? fullName;
  String? phone;
  String? language;
  bool? emailVerified;
  List<String>? roles;
  String? createdAt;

  UserProfileResponse(
      {this.userId,
        this.email,
        this.firstName,
        this.lastName,
        this.fullName,
        this.phone,
        this.language,
        this.emailVerified,
        this.roles,
        this.createdAt});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    phone = json['phone'];
    language = json['language'];
    emailVerified = json['emailVerified'];
    roles = json['roles'].cast<String>();
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['emailVerified'] = this.emailVerified;
    data['roles'] = this.roles;
    data['createdAt'] = this.createdAt;
    return data;
  }
}