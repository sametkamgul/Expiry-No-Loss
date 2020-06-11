class Item {
  final String itemType;
  final String itemName;
  final String itemDate;
  final int itemAmount;

  Item({this.itemType, this.itemName, this.itemDate, this.itemAmount});

  Map<String, dynamic> toMap() {
    return {
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
    return 'Item{itemType: $itemType, itemName: $itemName, itemDate: $itemDate, itemAmount: $itemAmount}';
  }
}