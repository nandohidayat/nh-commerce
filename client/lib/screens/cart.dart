import 'package:flutter/material.dart';
import '../services/book.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List picked = [false, false];

  double totalAmount = 0;

  pickToggle(index, price) {
    setState(() {
      picked[index] = !picked[index];
      getTotalAmount(price);
    });
  }

  getTotalAmount(price) {
    var count = 0;
    for (int i = 0; i < picked.length; i++) {
      if (picked[i]) {
        count = count + 1;
      }
      if (i == picked.length - 1) {
        setState(() {
          totalAmount = price * count;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(shrinkWrap: true, children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: [
                  Stack(children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                    ),
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      color: Colors.green,
                    ),
                    Positioned(
                      bottom: 450.0,
                      right: 100.0,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 500.0,
                      left: 150.0,
                      child: Container(
                          height: 300.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150.0),
                              color: Colors.greenAccent.withOpacity(0.5))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: IconButton(
                          alignment: Alignment.topLeft,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Positioned(
                        top: 75.0,
                        left: 15.0,
                        child: Text(
                          'Shopping Cart',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      top: 150.0,
                      child: Column(
                        children: <Widget>[
                          itemCard(
                              booklist.books[0].title,
                              'gray',
                              booklist.books[0].price,
                              booklist.books[0].cover,
                              true,
                              0),
                          itemCard(
                              booklist.books[1].title,
                              'gray',
                              booklist.books[1].price,
                              booklist.books[1].cover,
                              true,
                              1),
                          itemCard(
                              booklist.books[2].title,
                              'gray',
                              booklist.books[2].price,
                              booklist.books[2].cover,
                              false,
                              2)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 600.0, bottom: 15.0),
                    )
                  ])
                ])
              ])
        ]),
        bottomNavigationBar: Material(
          elevation: 7.0,
          color: Colors.white,
          child: Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Total: Rp ' + totalAmount.toString()),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      elevation: 0.5,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'Pay Now',
                        ),
                      ),
                      textColor: Colors.white,
                    ),
                  )
                ],
              )),
        ));
  }

  Widget itemCard(itemName, color, price, imgPath, available, i) {
    itemName =
        itemName.length > 17 ? itemName.substring(0, 15) + "..." : itemName;

    return InkWell(
      onTap: () {
        if (available) {
          pickToggle(i, price);
        }
      },
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 3.0,
              child: Container(
                  padding: EdgeInsets.only(left: 15.0, right: 10.0),
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                color: available
                                    ? Colors.grey.withOpacity(0.4)
                                    : Colors.red.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: Center(
                                  child: available
                                      ? Container(
                                          height: 12.0,
                                          width: 12.0,
                                          decoration: BoxDecoration(
                                              color: picked[i]
                                                  ? Colors.yellow
                                                  : Colors.grey
                                                      .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(6.0)),
                                        )
                                      : Container()))
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        height: 150.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: new NetworkImage(
                                  imgPath,
                                ),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(width: 4.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                itemName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              SizedBox(width: 7.0),
                              available
                                  ? picked[i]
                                      ? Text(
                                          'x1',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        )
                                      : Container()
                                  : Container()
                            ],
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? SizedBox(
                                  width: 10,
                                )
                              : OutlineButton(
                                  onPressed: () {},
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  child: Center(
                                    child: Text('Find Similar',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                            color: Colors.red)),
                                  ),
                                ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                                  'Rp ' + price.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.green),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  )))),
    );
  }
}
