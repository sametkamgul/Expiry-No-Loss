import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expiry_no_loss/components/constants.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

class ItemWidget extends StatefulWidget {
  final String itemType;
  final String itemName;
  final String itemDate;
  final int itemCountdown;
  final String daysLeftOrPassed;
  final bool isEditing;

  ItemWidget(
    {
      Key key,
      @required this.itemType,
      @required this.itemName,
      @required this.itemDate,
      @required this.itemCountdown,
      @required this.daysLeftOrPassed,
      this.isEditing,
    }
  ): super(key: key);
    @override
  _ItemWidgetState createState() => _ItemWidgetState();
  
}
// DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';


class _ItemWidgetState extends State<ItemWidget> {
  bool isEditing = false;
  bool isEditingContent = false;
  bool isCancelled = false;
  int selectedItemIndex = 0;
  Constants constants = new Constants();

  Future<void> deleteItem(String itemName, String itemType, String itemDateTime) async {
    // Get a reference to the database.
    final db = await createDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'items',
      // Use a `where` clause to delete a specific dog.
      where: "itemName = ? AND itemType = ? AND itemDate = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [itemName, itemType, itemDateTime],
    );
  }

  Future<dynamic> createDatabase() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      
      Path.join(await getDatabasesPath(), 'items.db'),
      
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


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          log('tap:       ' + widget.itemType + ', ' + widget.itemName + ', ' + widget.itemDate + ', ' + widget.itemCountdown.toString());
          if (widget.itemType == '1') {
            setState(() {
              this.selectedItemIndex = 1;
            });
          }
          else if (widget.itemType == '2') {
            setState(() {
              this.selectedItemIndex = 2;
            });
          }
          else if (widget.itemType == '3') {
            setState(() {
              this.selectedItemIndex = 3;
            });
          }
          else if (widget.itemType == '4') {
            setState(() {
              this.selectedItemIndex = 4;
            });
          }
          else {
            setState(() {
              this.selectedItemIndex = 0;
            });
          }
        },
        onLongPress: () {
          log('longpress: ' + widget.itemType + ', ' + widget.itemName + ', ' + widget.itemDate + ', ' + widget.itemCountdown.toString());
          setState(() {
            isEditing = true;
          });
        },
        child: new Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: 75.0,
          color: Colors.transparent,
          child: !isEditing ? itemNormal(): itemLongPressed(),
        ),
      ),
    );
  } 

  Widget itemNormal() {
    return new Container(
      decoration: new BoxDecoration(
        color: widget.itemType == '1' ? Color(constants.colorExpiry)
              : widget.itemType == '2' ? Color(constants.colorStock)
              : widget.itemType == '3' ? Color(constants.colorToDo)
              : widget.itemType == '4' ? Color(constants.colorToBuy)
              : Colors.blue,
        border: Border.all(
          width: 0,
          color: Colors.white   // TODO: maybe remove the stroke color!!!
        ),
        borderRadius: new BorderRadius.all(
          const Radius.circular(40.0),
          
        )
      ),
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.itemName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'exp: ' + widget.itemDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  widget.itemCountdown.toString() + widget.daysLeftOrPassed,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget itemLongPressed() {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.red,
        border: Border.all(
          width: 3,
          color: Colors.white   // TODO: maybe remove the stroke color!!!
        ),
        borderRadius: new BorderRadius.all(
          const Radius.circular(40.0),
          
        )
      ),
      child: new Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 100.0,
              child: GestureDetector(
                onTap: () {
                  log('pressed edit button');
                  setState(() {
                    isEditingContent = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemActionPage(
                        itemName: widget.itemName,
                        itemDate: widget.itemDate,
                      )),
                    );
                  });
                },
                child: Text(
                  'edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          
            Container(
              alignment: Alignment.center,
              width: 100.0,
              child: GestureDetector(
                onTap: () async {
                  log('pressed del button');
                  // TODO: delete the item from database here!!!
                  await deleteItem(widget.itemName, widget.itemType, widget.itemDate);
                },
                child: Text(
                  'delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              width: 100.0,
              child: GestureDetector(
                onTap: () {
                  log('cancelled editing');
                  setState(() {
                    isEditing = false;
                  });
                },
                child: Text(
                  'cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class ItemActionPage extends StatefulWidget {
  ItemActionPage({Key key, this.itemName, this.itemDate}) : super(key: key);
  final String itemName;
  final String itemDate;

  @override
  _ItemActionPageState createState() => _ItemActionPageState();
}

class _ItemActionPageState extends State<ItemActionPage> {
  String editedLabelText = '';
  String _editedLabelText;

  void initState() {
    super.initState();
    editedLabelText = widget.itemDate;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.itemDate);
    
    setState(() {
      _editedLabelText = editedLabelText;
    });
    // assigning the date value of the item
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.itemName,
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
                child: FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateFormat('dd/MM/yyyy').parse(widget.itemDate),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030)
                    ).then((value){
                      log(value.toString());
                      setState(() {
                        editedLabelText = DateFormat('dd/MM/yyyy').format(value);
                      });
                    });
                  },
                  child: Text(
                    _editedLabelText,
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
                      onPressed: () {
                        //TODO: save the edited information here!!!
                        Navigator.pop(context, 'saveDone');
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