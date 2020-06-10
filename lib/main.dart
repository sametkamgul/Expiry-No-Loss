import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'widgets/item.dart';
import 'widgets/bottomTab.dart';
import 'components/dbhelper.dart';
import 'components/constants.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expiry: No Loss',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Expire: No More'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.data, this.title, this.notify}) : super(key: key);

  final String title;
  final String data;
  final Function() notify;
  
  //final int selectedItemIndex;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool biggerExpiry = false;
  bool biggerStock = false;
  bool biggerToDo = false;
  bool biggerToBuy = false;
  int selectedItemIndex = 0;
  int counter = 0;
  final myController = TextEditingController(); // textfiel controller handles the data changes
  Constants constants = new Constants();

  @override
  void initState() {
    getUserData('all').then((_) {
      refresh(); // refreshing the page at the beginning
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  List listItemsAll = [];
  List itemsExpiryList = [];
  List itemsStockList = [];
  List itemsToDoList = [];
  List itemsToBuyList = [];
  int itemCountDown = 0;
  
  _MyHomePageState();


  Future<void> removeDatabase() async {
    log('database is deleted.');
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'items.db');

    // Delete the database
    await deleteDatabase(path);
  }

  Future<dynamic> createDatabase() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      
      join(await getDatabasesPath(), 'items.db'),
      
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, itemType TEXT, itemName TEXT, itemDate TEXT, itemAmount INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertItem(Item item) async {
    // Get a reference to the database.
    final Database db = await createDatabase();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> items() async {
    // Get a reference to the database.
    final Database db = await createDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('items');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        itemType: maps[i]['itemType'],
        itemName: maps[i]['itemName'],
        itemDate: maps[i]['itemDate'],
        itemAmount: maps[i]['itemAmount'],
      );
    });
  }

  Future<void> updateItem(Item item) async {
    // Get a reference to the database.
    final db = await createDatabase();

    // Update the given Dog.
    await db.update(
      'items',
      item.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    // Get a reference to the database.
    final db = await createDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'items',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<dynamic> getUserData (String dataChoice) async {
    
    if (dataChoice == 'expiry') {
      listItemsAll = await items();
      itemsExpiryList.clear();
      for(int x = 0; x<listItemsAll.length; x++)
      {
        if (listItemsAll[x].itemType == '1') {
          itemsExpiryList.add(listItemsAll[x]);
        }
        else {
          // don't add the value
        }
      }
      //print(itemsExpiryList);
      return itemsExpiryList;
    }
    else if ( dataChoice == 'stock') {
      listItemsAll = await items();
      itemsStockList.clear();
      for(int x = 0; x<listItemsAll.length; x++)
      {
        if (listItemsAll[x].itemType == '2') {
          itemsStockList.add(listItemsAll[x]);
        }
        else {
          // don't add the value
        }
      }
      //print(itemsStockList);
      return itemsStockList;
    }
    else if ( dataChoice == 'to-do') {
      listItemsAll = await items();
      itemsToDoList.clear();
      for(int x = 0; x<listItemsAll.length; x++)
      {
        if (listItemsAll[x].itemType == '3') {
          itemsToDoList.add(listItemsAll[x]);
        }
        else {
          // don't add the value
        }
      }
      //print(itemsToDoList);
      return itemsToDoList;
    }
    else if ( dataChoice == 'to-buy') {
      listItemsAll = await items();
      itemsToBuyList.clear();
      for(int x = 0; x<listItemsAll.length; x++)
      {
        if (listItemsAll[x].itemType == '4') {
          itemsToBuyList.add(listItemsAll[x]);
        }
        else {
          // don't add the value
        }
      }
      //print(itemsToBuyList);
      return itemsToBuyList;
    }
    else if ( dataChoice == 'all') {
      listItemsAll = await items();
      //print(listItemsAll);
      return listItemsAll;
    }
    else {
      return await items();
    }    
  }

  void refresh() {
    setState(() {
      //
    });
  }

  // returns the how many day/days left or passed
  int getItemCountdown(String d) {
    var _itemCountdown = DateFormat('dd/MM/yyyy').parse(d).difference(DateTime.now()).inDays;
    return _itemCountdown;
  }

  // returns the days passed or left situation in string
  String getItemCountDownStatus(String d) {
    var _i = this.getItemCountdown(d);
    if (_i <= 0) {
      if (_i == 0 || _i == 1) {
        return ' day passed';
      }
      else {
        return ' days passed';
      }
    }
    else {
      if (_i == 1) {
        return ' day left';
      }
      else {
        return ' days left';
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedItemIndex = 0;
    
    setState(() {
      _selectedItemIndex = this.selectedItemIndex;
      if (selectedItemIndex == 1) {
        getUserData('expiry').then((value) {
          this.refresh();
        });
      }
      else if (selectedItemIndex == 2) {
        getUserData('stock').then((value) {
          this.refresh();
        });
      }
      else if (selectedItemIndex == 3) {
        getUserData('to-do').then((value) {
          this.refresh();
        });
      }
      else if (selectedItemIndex == 4) {
        getUserData('to-buy').then((value) {
          this.refresh();
        });
      }
      else if (selectedItemIndex == 0) {
        getUserData('all').then((value) {
          this.refresh();
        });
      }
    });
    // full screen width and height
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    /* setState(() {
      selectedItemIndex = widget.selectedItemIndex;
    }); */
  
    return Scaffold(
      backgroundColor: Color(constants.colorPageBackground),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(),
            // List-Item-Builder
            
            if (_selectedItemIndex == 0)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: listItemsAll.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexAll) {
                    //log(listItemsAll.length.toString());
                    //getUserData('all');
                    //log(index.toString() + ': ' + listItems[index].toString());
                    return ItemWidget(
                      daysLeftOrPassed: getItemCountDownStatus(listItemsAll[indexAll].itemDate),
                      itemType: listItemsAll[indexAll].itemType,
                      itemName: listItemsAll[indexAll].itemName,
                      itemDate: listItemsAll[indexAll].itemDate,
                      itemCountdown: getItemCountdown(listItemsAll[indexAll].itemDate)
                    );
                  }
                ),
              ),
            ),
            if (_selectedItemIndex == 1)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: itemsExpiryList.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexExpiry) {
                    //log(itemsExpiryList.length.toString());
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (itemsExpiryList[indexExpiry].itemType == '1'){
                      return ItemWidget(
                        daysLeftOrPassed: getItemCountDownStatus(itemsExpiryList[indexExpiry].itemDate),
                        itemType: itemsExpiryList[indexExpiry].itemType,
                        itemName: itemsExpiryList[indexExpiry].itemName,
                        itemDate: itemsExpiryList[indexExpiry].itemDate,
                        itemCountdown: getItemCountdown(itemsExpiryList[indexExpiry].itemDate)
                      );
                    }
                    else {
                      return null;
                    }
                  }
                ),
              ),
            ),
            if (_selectedItemIndex == 2)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: itemsStockList.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexStock) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (itemsStockList.length > 0) {
                      if (itemsStockList[indexStock].itemType == '2'){
                        //print(itemsStockList);
                        return ItemWidget(
                          daysLeftOrPassed: getItemCountDownStatus(itemsStockList[indexStock].itemDate),
                          itemType: itemsStockList[indexStock].itemType,
                          itemName: itemsStockList[indexStock].itemName,
                          itemDate: itemsStockList[indexStock].itemDate,
                          itemCountdown: getItemCountdown(itemsStockList[indexStock].itemDate)
                        );
                      }
                      else {
                        return null;
                      }
                    }
                    else {
                      return null;
                    }
                  }
                ),
              ),
            ),
            if (_selectedItemIndex == 3)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: itemsToDoList.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxtToDo, int indexToDo) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (itemsToDoList[indexToDo].itemType == '3'){
                      return ItemWidget(
                        daysLeftOrPassed: getItemCountDownStatus(itemsToDoList[indexToDo].itemDate),
                        itemType: itemsToDoList[indexToDo].itemType,
                        itemName: itemsToDoList[indexToDo].itemName,
                        itemDate: itemsToDoList[indexToDo].itemDate,
                        itemCountdown: getItemCountdown(itemsToDoList[indexToDo].itemDate)
                      );
                    }
                    else {
                      return null;
                    }
                  }
                ),
              ),
            ),
            if (_selectedItemIndex == 4)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: itemsToBuyList.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexToBuy) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (itemsToBuyList[indexToBuy].itemType == '4'){
                      return ItemWidget(
                        daysLeftOrPassed: getItemCountDownStatus(itemsToBuyList[indexToBuy].itemDate),
                        itemType: itemsToBuyList[indexToBuy].itemType,
                        itemName: itemsToBuyList[indexToBuy].itemName,
                        itemDate: itemsToBuyList[indexToBuy].itemDate,
                        itemCountdown: getItemCountdown(itemsToBuyList[indexToBuy].itemDate)
                      );
                    }
                    else {
                      return null;
                    }
                  }
                ),
              ),
            ),


            //if (_selectedItemIndex != 0)
            // plus-sign add-button
            GestureDetector(
              onLongPress: () {
                setState(() {
                  removeDatabase();
                });
              },
              onTap: () async {
                log('tapped plus: adding new value');
                //print(await items());
    
                //parse datetime example
                //log(DateFormat('dd/MM/yyyy').parse('01/06/2020').toString());

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewItemPage(selectedItemIndex: selectedItemIndex)),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                curve: Curves.bounceInOut,
                padding: EdgeInsets.all(5.0),
                width: _selectedItemIndex == 0 ? 0.0 : 75.0,
                height: _selectedItemIndex == 0 ? 0.0 : 75.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  color: Colors.red,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    // vertical line
                    Container(
                      width: 8,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                    //horizontal line
                    Container(
                      width: 45,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Padding(padding: EdgeInsets.all(5.0),),
            
            // Bottom Tab Menu
            BottomTab(
              tab1: 'expiry', tab2: 'stock', tab3: 'to-do', tab4: 'to-buy',
              onSelectedItemIndexChange: (int val) => setState((){
                selectedItemIndex = val;
                log('selected_index:' + selectedItemIndex.toString());
              }),
            ),
          ],
        ),
      ),
    
    );
  }
}

class AddNewItemPage extends StatefulWidget {
  AddNewItemPage({Key key, @required this.selectedItemIndex}) : super(key: key);
  final selectedItemIndex;

  @override
  _AddNewItemPageState createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final myControllerItemName = TextEditingController();
  final myControllerItemAmount = TextEditingController();
  String dateButtonText = 'Set Expiry Date';
  int itemAmount = 0;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myControllerItemName.addListener(_printItemNameValue);
    myControllerItemAmount.addListener(_printItemNameValue);
  }

  void _printItemNameValue () async {
    log(myControllerItemName.text + ':' + myControllerItemAmount.text);
  }

  refresh() {
    setState(() {});
    log('parent refreshing');
  }

  Future<dynamic> createDatabase() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      
      join(await getDatabasesPath(), 'items.db'),
      
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, itemType TEXT, itemName TEXT, itemDate TEXT, itemAmount INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertItem(Item item) async {
    // Get a reference to the database.
    final Database db = await createDatabase();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text("Second Route"),
      ), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // item-name-texfield
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC88264),
                borderRadius: new BorderRadius.all(
                  Radius.circular(40.0),
                )
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextField(
                  controller: myControllerItemName,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'enter an item name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            //padding
            Padding(padding: EdgeInsets.all(5.0)),

            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC88264),
                borderRadius: new BorderRadius.all(
                  Radius.circular(40.0),
                )
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextField(
                  controller: myControllerItemAmount,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'enter an item amount',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            //padding
            Padding(padding: EdgeInsets.all(5.0)),

            //item-date-texfield
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC88264),
                borderRadius: new BorderRadius.all(
                  Radius.circular(40.0),
                )
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030)
                    ).then((value){
                      log(value.toString());
                      setState(() {
                        dateButtonText = DateFormat('dd/MM/yyyy').format(value);
                      });
                    });
                  },
                  child: Text(
                    dateButtonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 5.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC88264),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(40.0),
                      )
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        log(myControllerItemName.text);
                        var _item = Item(
                          itemType: widget.selectedItemIndex.toString(),
                          itemName: myControllerItemName.text,
                          itemDate: dateButtonText,
                          itemAmount: itemAmount,
                        );
                        await insertItem(_item);
                        log('item is added');
                        log('selected: ' + widget.selectedItemIndex.toString());
                        Navigator.pop(context);
                        /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(notify: refresh,),
                          ),  
                        ); */
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC88264),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(40.0),
                      )
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context, 'saveCancelled');
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),  
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
