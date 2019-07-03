import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:client/utilities/constant.dart';

Future<List<Product>> fetchProduct(Client client) async {
  final response = await get('$kurl/api/products');

  return compute(parseProducts, response.body);
}

List<Product> parseProducts(String responeBody) {
  final parsed = json.decode(responeBody)['data'].cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final int quantity;
  final double price;
  final String category;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.quantity,
    this.price,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      price: double.parse(json['price'].toString()),
      category: json['category'] as String,
    );
  }
}
