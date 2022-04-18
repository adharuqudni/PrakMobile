import 'package:flutter/material.dart';
import 'package:pertemuan_empat/detail_page.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

import 'model/menu.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");
var allDataMenu = getAllMenu();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = "all";
  List<Menu> dataMenu = allDataMenu;
  int totalPrice = 0;
  List<Menu> cart = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Menu"),
        ),
        leading: GestureDetector(
          onTap: () {

            setState(() {
              dataMenu = allDataMenu;
            });
          },
          child: Icon(
            Icons.home,  // add custom icons also
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    dataMenu = allDataMenu.where((i) => i.category == 'beverage').toList();
                  });
                },
                child: Icon(
                  Icons.emoji_food_beverage,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    dataMenu = allDataMenu.where((i) => i.category == 'food').toList();
                  });
                },
                child: Icon(
                    Icons.food_bank
                ),
              )
          ),
        ],
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _createListFoodCard(),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("Total Price Rp ${formatCurrency.format(totalPrice)}"),
        ),
      ),
    );
  }

  Widget _createListFoodCard() {

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
      ),
      itemCount: dataMenu.length,
      itemBuilder: (BuildContext context, int index) {
        return _createCard(dataMenu[index], context);
      },
    );
  }

  Widget _createCard(Menu data, BuildContext context) {
    void AddPrice(int price){
      setState(() {
        totalPrice += price;
      });
    }
    void removePrice(int price){
      setState(() {
        totalPrice = totalPrice - price < 0 ? 0 : totalPrice-price;
      });
    }
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(
              image: data.image,
              name: data.name,
              price: data.price,
              addPrice: AddPrice,
              removePrice: removePrice,
            );
          }));
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  data.image,
                  width: 300,
                ),
              )),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            data.desc,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Rp ${formatCurrency.format(data.price)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          LikeButton(),
                        ],
                      ))),

            ],
          ),
        ),
      ),
    );
  }
}
