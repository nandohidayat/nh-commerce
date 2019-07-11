import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:client/services/cart.dart';
import 'package:client/services/user.dart';
import 'package:client/screens/payment.dart';
import 'package:client/screens/shipping.dart';
import 'package:client/utilities/constant.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Text('Keranjang'),
          ],
        ),
      ),
      body: FutureBuilder<List<Cart>>(
        future: fetchCarts(Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? CartList(
                  carts: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class CartList extends StatefulWidget {
  final List<Cart> carts;

  CartList({this.carts});

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<int> quantities = [];
  var format = new NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );

  int getTotal() {
    int sum = 0;
    for (int i = 0; i < widget.carts.length; i++) {
      sum += (widget.carts[i].price * quantities[i]).round();
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: _buildList(widget.carts),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Total Harga',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${format.format(getTotal())}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShippingPage(
                                carts: widget.carts,
                                quantities: quantities,
                                total: getTotal(),
                              ),
                        ),
                      );
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black),
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Center(
                        child: Text(
                          'Beli',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildList(List<Cart> carts) {
    List<Widget> lists = [];
    for (var i = 0; i < carts.length; i++) {
      quantities.add(carts[i].quantity);
      lists.add(_buildRow(carts[i], i));
      lists.add(Divider());
    }
    return lists;
  }

  Widget _buildRow(Cart cart, int i) {
    var format = new NumberFormat.simpleCurrency(
      locale: 'ID',
      decimalDigits: 0,
    );
    TextEditingController _quantity =
        TextEditingController(text: quantities[i].toString());

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '$kurl/images/products/${cart.image}',
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${cart.name}'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${format.format(cart.price)}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                quantities[i] = quantities[i] - 1;
                              });
                            },
                            iconSize: 35,
                            color: Colors.green.shade400,
                          ),
                          Container(
                            width: 50,
                            child: TextField(
                              controller: _quantity,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  quantities[i] = int.parse(value);
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                quantities[i] = quantities[i] + 1;
                              });
                            },
                            iconSize: 35,
                            color: Colors.green.shade400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    bool status = await User().deleteCart(id: cart.id);
                    if (status) {
                      setState(() {
                        widget.carts.remove(cart);
                      });
                    }
                  },
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
