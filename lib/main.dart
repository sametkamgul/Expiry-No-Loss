import 'dart:developer';
import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Expiry: No Loss'),
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
      print(listItemsAll);
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
                    return ItemWidget(itemType: listItemsAll[indexAll].itemType, itemName: listItemsAll[indexAll].itemName, itemDateTime: listItemsAll[indexAll].itemDate, itemCountdown: 9);
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
                      return ItemWidget(itemType: itemsExpiryList[indexExpiry].itemType, itemName: itemsExpiryList[indexExpiry].itemName, itemDateTime: itemsExpiryList[indexExpiry].itemDate, itemCountdown: 9);
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
                        return ItemWidget(itemType: itemsStockList[indexStock].itemType, itemName: itemsStockList[indexStock].itemName, itemDateTime: itemsStockList[indexStock].itemDate, itemCountdown: 9);
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
                      return ItemWidget(itemType: itemsToDoList[indexToDo].itemType, itemName: itemsToDoList[indexToDo].itemName, itemDateTime: itemsToDoList[indexToDo].itemDate, itemCountdown: 9);
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
                      return ItemWidget(itemType: itemsToBuyList[indexToBuy].itemType, itemName: itemsToBuyList[indexToBuy].itemName, itemDateTime: itemsToBuyList[indexToBuy].itemDate, itemCountdown: 9);
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
                /* var fido = Item(
                  id: 1,
                  itemType: 'Expiry',
                  itemName: 'Peynir',
                  itemDate: '27/05/2023',
                  itemAmount: 10,
                );

                // Insert a dog into the database.
                await insertItem(fido); */

                // Print the list of dogs (only Fido for now).
                //print(await items());

                // Update Fido's age and save it to the database.
                /* fido = Item(
                  id: 2,
                  itemType: 'Expiry',
                  itemName: 'Ekmek',
                  itemDate: '19/09/2021',
                  itemAmount: 11,
                );
                await insertItem(fido); */
                /* var fido = Item(
                  id: counter,
                  itemType: selectedItemIndex.toString(),
                  itemName: 'Ekmek',
                  itemDate: '19/09/2021',
                  itemAmount: 32
                );
                counter++;
                await insertItem(fido); */

                // Delete Fido from the database.
                //await deleteDog(fido.id);

                // Print the list of dogs (empty).
                //print(await items());

                //print(await items());

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
  final myControllerItemDate = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myControllerItemName.addListener(_printItemNameValue);
    myControllerItemDate.addListener(_printItemNameValue);
  }

  void _printItemNameValue () async {
    //log(myControllerItemName.text + ':' + myControllerItemDate.text);
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
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'item name',
                    hintStyle: TextStyle(
                      color: Colors.white,
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
                child: TextField(
                  controller: myControllerItemDate,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'dd/mm/yyyy',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      log(myControllerItemName.text);
                      log(myControllerItemDate.text);
                      var fido = Item(
                        itemType: widget.selectedItemIndex.toString(),
                        itemName: myControllerItemName.text,
                        itemDate: myControllerItemDate.text,
                        itemAmount: 32
                      );
                      await insertItem(fido);
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
                    child: Text('Save'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, 'saveCancelled');
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
