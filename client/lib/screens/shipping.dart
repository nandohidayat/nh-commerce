import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:client/services/cart.dart';
import 'package:client/utilities/constant.dart';

class ShippingPage extends StatelessWidget {
  ShippingPage({this.carts, this.quantities, this.total});

  final List<Cart> carts;
  final List<int> quantities;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengiriman'),
      ),
      body: ShippingDetails(
        carts: carts,
        quantities: quantities,
        total: total,
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

class ShippingDetails extends StatefulWidget {
  ShippingDetails({this.carts, this.quantities, this.total});

  final List<Cart> carts;
  final List<int> quantities;
  final int total;

  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  var format = new NumberFormat.simpleCurrency(
    locale: 'ID',
    decimalDigits: 0,
  );

  int getQuantity() {
    int sum = 0;
    for (int i = 0; i < widget.carts.length; i++) {
      sum += widget.quantities[i];
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: itemsList(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ringkasan(),
        SizedBox(
          height: 8,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Dengan mengaktifkan fitur perlindungan, saya menyetujui ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      wordSpacing: 2,
                    ),
                  ),
                  TextSpan(
                    text: 'Syarat dan Ketentuan',
                    style: TextStyle(
                      color: Colors.green,
                      wordSpacing: 2,
                    ),
                  ),
                  TextSpan(
                    text: ' yang berlaku.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
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
                        'Total Tagihan',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${format.format(widget.total)}',
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
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => ShippingPage(
//                            carts: widget.carts,
//                            quantities: quantities,
//                            total: getTotal(),
//                          ),
//                        ),
//                      );
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

  List<Widget> itemsList() {
    List<Widget> list = [];
    for (int i = 0; i < widget.carts.length; i++) {
      list.add(_buildRow(widget.carts[i], widget.quantities[i], i));
      list.add(Divider());
    }
    list.add(subTotal());
    return list;
  }

  Widget subTotal() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Sub total',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            '${format.format(widget.total)}',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget ringkasan() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ringkasan Belanja',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Harga (${getQuantity()} Barang)',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${format.format(widget.total)}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Ongkos Kirim',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Rp0',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Cart cart, int quantities, int i) {
    var format = new NumberFormat.simpleCurrency(
      locale: 'ID',
      decimalDigits: 0,
    );

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
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
                  width: MediaQuery.of(context).size.width * 0.75,
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
                        '$quantities barang',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
