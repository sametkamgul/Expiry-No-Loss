import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Item {
  final int id;
  final String itemName;
  final int itemDate;

  Item({this.id, this.itemName, this.itemDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'itemDate': itemDate,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Item{id: $id, itemNAme: $itemName, itemDate: $itemDate}';
  }
}