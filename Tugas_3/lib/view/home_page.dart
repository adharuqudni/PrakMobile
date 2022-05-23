import 'package:flutter/material.dart';
import 'package:pertemuan_empat/view/detail_page.dart';
import 'package:pertemuan_empat/view/menu_page.dart';
import 'package:pertemuan_empat/data/hive_database.dart';
import 'package:pertemuan_empat/data/SharedPref.dart';
import 'package:pertemuan_empat/model/Transaction.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';


final formatCurrency = new NumberFormat("#,##0.00", "en_US");
var allDataMenu = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri apiUrl = Uri.parse("https://mekidi.free.beeceptor.com/");
  String filter = "all";
  List<dynamic> dataMenu = allDataMenu;
  int totalPrice = 0;
  List<dynamic> cart = [];

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(apiUrl);
    allDataMenu = json.decode(result.body);
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Menu"),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return MenuPage();
            }));
          },
          child: Icon(
            Icons.home, // add custom icons also
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    dataMenu = allDataMenu
                        .where((i) => i["category"] == 'beverage')
                        .toList();
                  });
                },
                child: Icon(
                  Icons.emoji_food_beverage,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    dataMenu = allDataMenu
                        .where((i) => i["category"] == 'food')
                        .toList();
                  });
                },
                child: Icon(Icons.food_bank),
              )),
        ],
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _createListFoodCard(),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          // Add your onPressed code here!
          String promo = await SharedPref().getPromoCode();
          String username = await SharedPref().getUsername();
          log("${promo}, ${username}");
          final transaction = await Transaction(promoCode: promo.isEmpty ? "Tanpa Promo" : promo, username: username, price: totalPrice);
          HiveDatabase().addData(transaction);
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
    return FutureBuilder<List<dynamic>>(
      future: _fecthDataUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.5,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return _createCard(snapshot.data[index], context);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createCard(dynamic data, BuildContext context) {
    void AddPrice(int price) {
      setState(() {
        totalPrice += price;
      });
    }

    void removePrice(int price) {
      setState(() {
        totalPrice = totalPrice - price < 0 ? 0 : totalPrice - price;
      });
    }

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(
              image: data["image"],
              name: data["name"],
              price: data["price"],
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
                  data["image"],
                  width: 300,
                ),
              )),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            data["name"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            data["desc"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Rp ${formatCurrency.format(data["price"])}",
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
