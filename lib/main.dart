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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _biggerExpiry = false;
  bool _biggerStock = false;
  bool _biggerToDo = false;
  bool _biggerToBuy = false;

  @override
  Widget build(BuildContext context) {
    // full screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
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
            //Expanded(child: Text('tetet')),
            


            Expanded(
              child: ListView(      
                //shrinkWrap: true,          
                children: <Widget>[
                  ItemWidget(itemType: 'expiry', itemName: 'Portakal', itemDateTime: '04/06/2020', itemCountdown: 50),
                  ItemWidget(itemType: 'expiry', itemName: 'Elma', itemDateTime: '05/06/2020', itemCountdown: 10),
                  ItemWidget(itemType: 'to-buy', itemName: 'Süt', itemDateTime: '06/08/2020', itemCountdown: 5),
                  ItemWidget(itemType: 'to-do', itemName: 'Domates', itemDateTime: '24/07/2020', itemCountdown: 15),
                  ItemWidget(itemType: 'expiry', itemName: 'Domates', itemDateTime: '24/07/2020', itemCountdown: 15),
                  ItemWidget(itemType: 'to-do', itemName: 'Domates', itemDateTime: '24/07/2020', itemCountdown: 15),
                  ItemWidget(itemType: 'to-buy', itemName: 'Domates', itemDateTime: '24/07/2020', itemCountdown: 15),
                  ItemWidget(itemType: 'expiry', itemName: 'Domates', itemDateTime: '24/07/2020', itemCountdown: 15),
                  ItemWidget(itemType: 'stock', itemName: 'Yoğurt', itemDateTime: '24/07/2020', itemCountdown: 15),
                ],
              ),
            ),

            // Bottom Tab Menu
            BottomTab(tab1: 'expiry', tab2: 'stock', tab3: 'to-do', tab4: 'to-buy'),
          ],
        ),
      ),
    
    );
  }
}
