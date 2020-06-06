import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Item {
  final int id;
  final String itemType;
  final String itemName;
  final String itemDate;
  final int itemAmount;

  Item({this.id, this.itemType, this.itemName, this.itemDate, this.itemAmount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemType': itemType,
      'itemName': itemName,
      'itemDate': itemDate,
      'itemAmount' : itemAmount,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Item{id: $id, itemType: $itemType, itemName: $itemName, itemDate: $itemDate, itemAmount: $itemAmount}';
  }
}