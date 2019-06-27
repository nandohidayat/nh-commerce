import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:client/common/constant.dart';
import 'dart:convert';

class User {
  User(
      {this.id,
      this.email,
      this.username,
      this.name,
      this.phone,
      this.address});

  final String id;
  final String email;
  final String username;
  final String name;
  final String phone;
  final String address;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        email: json['itemCode'],
        username: json['usename'],
        name: json['name'],
        phone: json['phone'],
        address: json['address']);
  }

  List<User> parseUsers(String respone) {
    final parsed = json.decode(respone).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<int> login({String email, String password}) async {
    var response =
        await post('$url/signin', body: {'email': email, 'password': password});

    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonDecode(response.body)['token']);
      print(jsonDecode(response.body)['token']);
      return 201;
    } else {
      return response.statusCode;
    }
  }
}
