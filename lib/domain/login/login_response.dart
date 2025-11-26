class LoginResponse {
  String? token;
  String? userId;
  String? message;
  String? firstName;
  String? lastName;
  String? fullName;
  List<String>? roles;
  String? language;

  LoginResponse(
      {this.token,
        this.userId,
        this.message,
        this.firstName,
        this.lastName,
        this.fullName,
        this.roles,
        this.language});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    message = json['message'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    roles = json['roles'].cast<String>();
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['roles'] = this.roles;
    data['language'] = this.language;
    return data;
  }
}