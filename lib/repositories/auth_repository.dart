import 'dart:convert';
import 'package:flutter_login_bloc/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String apiURL = "http://api.midodaren.com/api/";

class AuthRepository {
  Future loginUser(String _email, String _password, String device) async {
    try {
      var res = await http.post(
        apiURL + "login",
        body: {
          'email': _email,
          'password': _password,
          'device_name': device,
        },
      );
      var jsonRes = json.decode(res.body);
      return AuthLogin.fromJson(jsonRes);
    } catch (e) {
      return e;
    }
  }

  Future logoutUser(String token) async {
    try {
      var res = await http.get(apiURL + "logout", headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      var jsonRes = json.decode(res.body);
      return AuthLogout.fromJson(jsonRes);
    } catch (e) {
      return e;
    }
  }

  Future getUser(String token) async {
    try {
      var res = await http.get(apiURL + "profile", headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      var jsonRes = json.decode(res.body);
      return AuthUser.fromJson(jsonRes);
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String token = local.getString("token");
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString('token', token);
  }

  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.remove('token');
  }
}
