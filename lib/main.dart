import 'dart:developer';

import 'package:flutter/material.dart';
import 'widgets/item.dart';
import 'widgets/bottomTab.dart';

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
  MyHomePage({Key key, this.data, this.title}) : super(key: key);

  final String title;
  final String data;
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
  String _data = 'init';

  //mocking data
  List listItemExpiry = [
    {'itemType' : 'expiry', 'itemName' : 'Yumurta', 'itemDate' : '14/08/2020'},
    {'itemType' : 'expiry', 'itemName' : 'Süt', 'itemDate' : '23/10/2020'},
    {'itemType' : 'expiry', 'itemName' : 'Peynir', 'itemDate' : '23/10/2020'},
  ];
  List listItemStock = [
    {'itemType' : 'stock', 'itemName' : 'Nutella', 'itemDate' : '11/07/2020'},
    {'itemType' : 'stock', 'itemName' : 'Ekmek', 'itemDate' : '11/07/2020'},
  ];
  List listItemTodo = [
    {'itemType' : 'to-do', 'itemName' : 'Pirinç', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-do', 'itemName' : 'Tuz', 'itemDate' : '11/07/2020'},
  ];
  List listItemToBuy = [
    {'itemType' : 'to-buy', 'itemName' : 'Kekik', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-buy', 'itemName' : 'Püskevit', 'itemDate' : '11/07/2020'},
  ];
  List listItemsAll = [
    {'itemType' : 'expiry', 'itemName' : 'Yumurta', 'itemDate' : '14/08/2020'},
    {'itemType' : 'expiry', 'itemName' : 'Süt', 'itemDate' : '23/10/2020'},
    {'itemType' : 'stock', 'itemName' : 'Nutella', 'itemDate' : '11/07/2020'},
    {'itemType' : 'stock', 'itemName' : 'Ekmek', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-do', 'itemName' : 'Pirinç', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-do', 'itemName' : 'Tuz', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-buy', 'itemName' : 'Kekik', 'itemDate' : '11/07/2020'},
    {'itemType' : 'to-buy', 'itemName' : 'Püskevit', 'itemDate' : '11/07/2020'},
    {'itemType' : 'expiry', 'itemName' : 'Peynir', 'itemDate' : '23/10/2020'},
  ];
  
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    int _selectedItemIndex;

    setState(() {
      _selectedItemIndex = this.selectedItemIndex;
    });
    // full screen width and height
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    /* setState(() {
      selectedItemIndex = widget.selectedItemIndex;
    }); */

    log('loaded:' + _selectedItemIndex.toString());
  
    return Scaffold(
      backgroundColor: Colors.greenAccent,
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
                    log(listItemsAll.length.toString());
                    //log(index.toString() + ': ' + listItems[index].toString());
                    return new ItemWidget(itemType: listItemsAll[indexAll]['itemType'], itemName: listItemsAll[indexAll]['itemName'], itemDateTime: listItemsAll[indexAll]['itemDate'], itemCountdown: 9);
                  }
                ),
              ),
            ),
            if(_selectedItemIndex == 1)
            new Container(
              child: new Expanded(
                child: new ListView.builder(
                  itemCount: listItemExpiry.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexExpiry) {
                    log(listItemExpiry.length.toString());
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (listItemExpiry[indexExpiry]['itemType'] == 'expiry'){
                      return new ItemWidget(itemType: listItemExpiry[indexExpiry]['itemType'], itemName: listItemExpiry[indexExpiry]['itemName'], itemDateTime: listItemExpiry[indexExpiry]['itemDate'], itemCountdown: 9);
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
                  itemCount: listItemStock.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexStock) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (listItemStock[indexStock]['itemType'] == 'stock'){
                      return new ItemWidget(itemType: listItemStock[indexStock]['itemType'], itemName: listItemStock[indexStock]['itemName'], itemDateTime: listItemStock[indexStock]['itemDate'], itemCountdown: 9);
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
                  itemCount: listItemTodo.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxtToDo, int indexToDo) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (listItemTodo[indexToDo]['itemType'] == 'to-do'){
                      return new ItemWidget(itemType: listItemTodo[indexToDo]['itemType'], itemName: listItemTodo[indexToDo]['itemName'], itemDateTime: listItemTodo[indexToDo]['itemDate'], itemCountdown: 9);
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
                  itemCount: listItemToBuy.length,
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  itemBuilder: (BuildContext ctxt, int indexToBuy) {
                    //log(index.toString() + ': ' + listItems[index].toString());
                    if (listItemToBuy[indexToBuy]['itemType'] == 'to-buy'){
                      return new ItemWidget(itemType: listItemToBuy[indexToBuy]['itemType'], itemName: listItemToBuy[indexToBuy]['itemName'], itemDateTime: listItemToBuy[indexToBuy]['itemDate'], itemCountdown: 9);
                    }
                    else {
                      return null;
                    }
                  }
                ),
              ),
            ),

            
            
            // Bottom Tab Menu
            BottomTab(
              tab1: 'expiry', tab2: 'stock', tab3: 'to-do', tab4: 'to-buy',
              onSelectedItemIndexChange: (int val) => setState((){
                selectedItemIndex = val;
                log('testttt:' + selectedItemIndex.toString());
              }),
            ),
          ],
        ),
      ),
    
    );
  }
}
