import 'package:flutter/material.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Container(),
            //Expanded(child: Text('tetet')),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[

                //item
                Padding(padding: EdgeInsets.only(top: 5.0)),
                GestureDetector(
                  onTap: () {
                    print("item-1");
                  },
                  child: new Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    height: 75.0,
                    color: Colors.transparent,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Color(0xFFC88264),
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
                              'Orange',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  '03/06/2020',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  '1 day left',
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
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(top: 5.0)),
                // item-2
                GestureDetector(
                  onTap: () {
                    print('item-2');
                  },
                  onLongPress: () {
                    print('editing');
                  },
                  child: new Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    height: 75.0,
                    color: Colors.transparent,
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Color(0xFFC88264),
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
                              'Milk',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  '03/06/2020',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  '1 day left',
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
                    ),
                  ),
                ),
              ],
            ),

/* 
              ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
                children: <Widget>[
                  
                ],
              ), */

              // bottom menu
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[

                    // Expiry-menu item
                    Align(
                      alignment: Alignment.bottomRight,
                      child: new AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceInOut,
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        height: !_biggerExpiry ? 48.0 : 96.0,
                        width: screenWidth,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            print('bigger-expiry');
                            setState(() {
                              _biggerExpiry = !_biggerExpiry;
                              _biggerStock = false;
                              _biggerToDo = false;
                              _biggerToBuy = false;
                            });
                          },
                          child: new Container(
                            width: 4.0 * screenWidth / 4.0,
                            decoration: new BoxDecoration(
                              color: Color(0xFFC88264),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                              )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,                              
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth / 4.0,
                                      child: Align(
                                        alignment: Alignment.center ,
                                        child: Text(
                                          'expiry',
                                          style: TextStyle(
                                            fontSize: !_biggerExpiry ? 18.0 : 28.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Stock-menu item
                    Align(
                      alignment: Alignment.bottomRight,
                      child: new AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceInOut,
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        height: !_biggerStock ? 48.0 : 96.0,
                        width: 3.0 * screenWidth / 4.0,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            print('bigger_stock');
                            setState(() {
                              _biggerExpiry = false;
                              _biggerStock = !_biggerStock;
                              _biggerToDo = false;
                              _biggerToBuy = false;
                            });
                          },
                          child: new Container(
                            width: screenWidth / 4.0,
                            decoration: new BoxDecoration(
                              color: Color(0xFF6B75E3),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                              )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth / 4.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'stock',
                                          style: TextStyle(
                                            fontSize: !_biggerStock ? 18.0 : 28.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //  to-do-menu item
                    Align(
                      alignment: Alignment.bottomRight,
                      child: new AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceInOut,
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        height: !_biggerToDo ? 48.0 : 96.0,
                        width: 2.0 * screenWidth / 4.0,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            print('bigger_todo');
                            setState(() {
                              _biggerExpiry = false;
                              _biggerStock = false;
                              _biggerToDo = !_biggerToDo;
                              _biggerToBuy = false;

                            });
                          },
                          child: new Container(
                            width: screenWidth / 4.0,
                            decoration: new BoxDecoration(
                              color: Color(0xFF7BB076),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                              )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth / 4.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'to-do',
                                          style: TextStyle(
                                            fontSize: !_biggerToDo ? 18.0 : 28.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //  to-buy-menu item
                    Align(
                      alignment: Alignment.bottomRight,
                      child: new AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceInOut,
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        height: !_biggerToBuy ? 48.0 : 96.0,
                        width: 1.0 * screenWidth / 4.0,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            print('bigger_tobuy');
                            setState(() {
                              _biggerExpiry = false;
                              _biggerStock = false;
                              _biggerToDo = false;
                              _biggerToBuy = !_biggerToBuy;
                            });
                          },
                          child: new Container(
                            width: screenWidth / 4.0,
                            decoration: new BoxDecoration(
                              color: Color(0xFFD86579),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                              )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth / 4.0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'to-buy',
                                          style: TextStyle(
                                            fontSize: !_biggerToBuy ? 18.0 : 28.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ),
          ],
        ),
      ),
    
    );
  }
}
