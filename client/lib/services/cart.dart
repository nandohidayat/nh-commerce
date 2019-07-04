import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:client/utilities/constant.dart';

Future<List<Cart>> fetchCarts(Client client) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.get('token');

  final response = await get(
    '$kurl/api/auth/carts',
    headers: {'authorization': 'Bearer $token'},
  );

  return compute(parseCarts, response.body);
}

List<Cart> parseCarts(String responeBody) {
  final parsed = json.decode(responeBody)['data'].cast<Map<String, dynamic>>();

  return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
}

class Cart {
  final String id;
  final String productId;
  final String name;
  final String image;
  final int quantity;
  final double price;

  Cart({
    this.id,
    this.productId,
    this.name,
    this.image,
    this.quantity,
    this.price,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'] as String,
      productId: json['product']['_id'] as String,
      name: json['product']['name'] as String,
      image: json['product']['image'] as String,
      price: double.parse(json['product']['price'].toString()),
      quantity: json['quantity'] as int,
    );
  }
}
