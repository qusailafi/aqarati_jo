class RegisterResponse {
  String? message;
  String? userId;
  String? firstName;
  String? lastName;
  String? fullName;
  List<String>? roles;
  String? language;

  RegisterResponse(
      {this.message,
        this.userId,
        this.firstName,
        this.lastName,
        this.fullName,
        this.roles,
        this.language});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    roles = json['roles'].cast<String>();
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['roles'] = this.roles;
    data['language'] = this.language;
    return data;
  }
}