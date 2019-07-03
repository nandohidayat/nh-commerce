import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return 404;
    }
  }

  Future postData({Object object}) async {
    Response response = await post(url, body: object);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return 404;
    }
  }
}
