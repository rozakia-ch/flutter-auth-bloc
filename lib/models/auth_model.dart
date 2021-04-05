class AuthLogin {
  bool? success;
  var message;
  AuthToken? data;
  AuthLogin({this.message, this.data});
  AuthLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = AuthToken.fromJson(json['data']);
  }
}

class AuthToken {
  String? token;
  AuthToken({this.token});
  AuthToken.fromJson(Map<String, dynamic>? data) {
    token = (data != null) ? data['token'] : null;
  }
}

class AuthUser {
  String? name;
  String? email;
  AuthUser({this.name, this.email});
  AuthUser.fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      name = data['data']['name'];
      email = data['data']['email'];
    } else {
      name = "";
      email = "";
    }
  }
}

class AuthLogout {
  bool? success;
  String? message;
  AuthLogout({this.message});
  AuthLogout.fromJson(Map<String, dynamic> data) {
    message = data['message'];
    success = data['success'];
  }
}
