import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/utilities/constant.dart';
import 'package:client/services/networking.dart';

class User {
  Future<bool> login({String email, String password}) async {
    NetworkHelper networkHelper = NetworkHelper(url: '$kurl/api/auth');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await networkHelper.postData(
      object: {'email': email, 'password': password},
    );
    if (data == 404) {
      return false;
    } else {
      await prefs.setString('token', data['token']);
      return true;
    }
  }

  Future<bool> signup(
      {String email, String name, String phone, String password}) async {
    NetworkHelper networkHelper = NetworkHelper(url: '$kurl/api/auth/signup');
    var data = await networkHelper.postData(
      object: {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
      },
    );
    if (data == 404) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> addToCart({String product, int quantity}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');

    NetworkHelper networkHelper = NetworkHelper(url: '$kurl/api/auth/cart');
    var data = await networkHelper.postData(
      object: {
        'product': product,
        'quantity': quantity.toString(),
      },
      token: token,
    );

    if (data == 404) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> deleteCart({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');

    NetworkHelper networkHelper = NetworkHelper(url: '$kurl/api/auth/cart/$id');
    var data = await networkHelper.deleteData(
      token: token,
    );

    if (data == 404) {
      return false;
    } else {
      return true;
    }
  }
}
