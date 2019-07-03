import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/utilities/constant.dart';
import 'package:client/services/networking.dart';

class User {
  Future<bool> login({String email, String password}) async {
    NetworkHelper networkHelper = NetworkHelper(url: '$kurl/api/auth');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await networkHelper.postData(
      object: {'email': email, 'password': password},
    );
    if (token == 404) {
      return false;
    } else {
      await prefs.setString('token', token['token']);
      return true;
    }
  }
}
