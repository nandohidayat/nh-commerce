import 'package:flutter/material.dart';
import 'package:client/utilities/constant.dart';

class DetailPage extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final String description;
  final int quantity;

  DetailPage({
    this.image,
    this.name,
    this.price,
    this.description,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Image.network('$kurl$image'),
        ],
      ),
    );
  }
}
