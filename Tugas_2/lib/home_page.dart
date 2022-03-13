import 'package:flutter/material.dart';
import 'package:pertemuan_empat/detail_page.dart';

import 'model/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Menu"),
        ),
        backgroundColor: Color.fromRGBO(218, 41, 28, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _createListCard(),
      ),
    );
  }

  Widget _createListCard() {
    var dataMovie = getData;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: dataMovie.length,
      itemBuilder: (BuildContext context, int index) {
        return _createCard(dataMovie[index], context);
      },
    );
  }

  Widget _createCard(Menu data, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(
              image: data.image,
              name: data.name,
              price: data.price,

            );
          }));
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.network(
                  data.image,
                  width: 300,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
