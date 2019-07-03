import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

import 'package:client/services/product.dart';
import 'package:client/utilities/constant.dart';
import 'package:client/screens/detail.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: 'Cari di Bu Ratna',
            fillColor: Colors.grey.shade100,
            filled: true,
            contentPadding: EdgeInsets.all(9),
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ProductList(
                  products: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.73,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 10,
      children: List.generate(
        products.length,
        (index) {
          return ProductCard(
            image: products[index].image,
            name: products[index].name,
            price: products[index].price,
            description: products[index].description,
            quantity: products[index].quantity,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final String description;
  final int quantity;
  final format = new NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );

  ProductCard({
    this.image,
    this.name,
    this.price,
    this.description,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    String title = name.length > 40 ? name.substring(0, 38) + '...' : name;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
                  image: image,
                  name: name,
                  description: description,
                  price: price,
                  quantity: quantity,
                ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                '$kurl$image',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$title'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${format.format(price)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
