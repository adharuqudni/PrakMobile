import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pertemuan_empat/model/Transaction.dart';

class HiveDatabase {

  Box<Transaction> localDBBox = Hive.box<Transaction>("transactionDB");

  void addData(Transaction transaction) {
    localDBBox.add(transaction);
  }

  Transaction? getTransactionAt(int position) {
    return localDBBox.getAt(position);
  }

  void deleteAt(int position) {
    localDBBox.deleteAt(position);
  }

  void putTransactionAt(int position, Transaction value) {
    localDBBox.putAt(position, value);
  }

  int getLength() {
    return localDBBox.length;
  }
}