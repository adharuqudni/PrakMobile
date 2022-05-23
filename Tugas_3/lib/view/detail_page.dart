import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");

class DetailPage extends StatelessWidget {
  // final Movie movie;
  final String image;
  final String name;
  final int price;
  final Function addPrice;
  final Function removePrice;


  const DetailPage({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.addPrice,
    required this.removePrice,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.network(
                image,
                width: double.infinity,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Rp ${formatCurrency.format(price)}",

                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Color.fromRGBO(218, 41, 28, 1),
              onTap: () { addPrice(price); },
              label: 'Add to cart',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Color.fromRGBO(218, 41, 28, 1)),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.remove),
              backgroundColor: Color.fromRGBO(218, 41, 28, 1),
              onTap: () {
                removePrice(price);
              },
              label: 'Minus to cart',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Color.fromRGBO(218, 41, 28, 1))
        ],
      )
    );
  }
}
