import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pertemuan_empat/view/login_page.dart';
import 'model/Transaction.dart';

void main() {
  _initDB();
  runApp(const MyApp());
}

void _initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.deleteBoxFromDisk('transactionDB');
  await Hive.openBox<Transaction>("transactionDB");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
