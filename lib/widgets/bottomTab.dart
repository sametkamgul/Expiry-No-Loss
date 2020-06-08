import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:expiry_no_loss/components/constants.dart';

class BottomTab extends StatefulWidget {
  final String tab1;
  final String tab2;
  final String tab3;
  final String tab4;
  final Function(int) onSelectedItemIndexChange;

  BottomTab({Key key,
    @required this.tab1,
    @required this.tab2,
    @required this.tab3,
    @required this.tab4,
    this.onSelectedItemIndexChange,
  }) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  bool biggerExpiry = false;
  bool biggerStock = false;
  bool biggerToBuy = false;
  bool biggerToDo = false;
  Constants constants = new Constants();

  @override
  Widget build(BuildContext context) {
    // full screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Expiry-menu item
          Align(
            alignment: Alignment.bottomRight,
            child: new AnimatedContainer(
              color: Colors.transparent,
              duration: Duration(milliseconds: 100),
              curve: Curves.bounceInOut,
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              height: !this.biggerExpiry ? 48.0 : 96.0,
              width: screenWidth,
              child: GestureDetector(
                onTap: () {
                  if (this.biggerExpiry == true){
                    widget.onSelectedItemIndexChange(0);
                  }
                  else{
                    widget.onSelectedItemIndexChange(1);
                  }
                  setState(() {
                    this.biggerExpiry = !this.biggerExpiry;
                    this.biggerStock = false;
                    this.biggerToDo = false;
                    this.biggerToBuy = false;
                  });
                  log('tab: ' + widget.tab1);
                },
                child: new Container(
                  width: 4.0 * screenWidth / 4.0,
                  decoration: new BoxDecoration(
                    color: Color(constants.colorExpiry),
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
                                widget.tab1,
                                style: TextStyle(
                                  fontSize: !this.biggerExpiry ? 18.0 : 28.0,
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
              height: !this.biggerStock ? 48.0 : 96.0,
              width: 3.0 * screenWidth / 4.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  if (this.biggerStock == true){
                    widget.onSelectedItemIndexChange(0);
                  }
                  else{
                    widget.onSelectedItemIndexChange(2);
                  }
                  setState(() {
                    this.biggerStock = !this.biggerStock;
                    this.biggerExpiry = false;
                    this.biggerToDo = false;
                    this.biggerToBuy = false;
                  });
                  log('tab: ' + widget.tab2);
                },
                child: new Container(
                  width: screenWidth / 4.0,
                  decoration: new BoxDecoration(
                    color: Color(constants.colorStock),
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
                                widget.tab2,
                                style: TextStyle(
                                  fontSize: !this.biggerStock ? 18.0 : 28.0,
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
              height: !this.biggerToDo ? 48.0 : 96.0,
              width: 2.0 * screenWidth / 4.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  if (this.biggerExpiry == false && this.biggerStock == false && this.biggerToDo == true && this.biggerToBuy == false){
                    widget.onSelectedItemIndexChange(0);
                  }
                  else{
                    widget.onSelectedItemIndexChange(3);
                  }
                  setState(() {
                    this.biggerToDo = !this.biggerToDo;
                    this.biggerExpiry = false;
                    this.biggerStock = false;
                    this.biggerToBuy = false;
                  });
                  log('tab: ' + widget.tab3);
                },
                child: new Container(
                  width: screenWidth / 4.0,
                  decoration: new BoxDecoration(
                    color: Color(constants.colorToDo),
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
                                widget.tab3,
                                style: TextStyle(
                                  fontSize: !this.biggerToDo ? 18.0 : 28.0,
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
              height: !this.biggerToBuy ? 48.0 : 96.0,
              width: 1.0 * screenWidth / 4.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  if (this.biggerExpiry == false && this.biggerStock == false && this.biggerToDo == false && this.biggerToBuy == true){
                    widget.onSelectedItemIndexChange(0);
                  }
                  else{
                    widget.onSelectedItemIndexChange(4);
                  }
                  setState(() {
                    this.biggerToBuy = !this.biggerToBuy;
                    this.biggerExpiry = false;
                    this.biggerStock = false;
                    this.biggerToDo = false;
                  });
                  log('tab: ' + widget.tab4);
                },
                child: new Container(
                  width: screenWidth / 4.0,
                  decoration: new BoxDecoration(
                    color: Color(constants.colorToBuy),
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
                                widget.tab4,
                                style: TextStyle(
                                  fontSize: !this.biggerToBuy ? 18.0 : 28.0,
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
      ),
    );
  }
}