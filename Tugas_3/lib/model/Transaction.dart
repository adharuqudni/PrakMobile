import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'Transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String promoCode;

  @HiveField(1)
  int price;

  @HiveField(2, defaultValue: '')
  String username;

  Transaction({required this.promoCode, required this.username, required this.price});
}