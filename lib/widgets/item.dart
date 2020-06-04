import 'dart:developer';

import 'package:expiry_no_loss/components/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final String itemType;
  final String itemName;
  final String itemDateTime;
  final int itemCountdown;

  ItemWidget(
    {
      Key key,
      @required this.itemType,
      @required this.itemName,
      @required this.itemDateTime,
      @required this.itemCountdown,
    }
  ): super(key: key);
    @override
  _ItemWidgetState createState() => _ItemWidgetState();
  
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isEditing = false;
  bool isEditingContent = false;
  bool isCancelled = false;
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          log('tap:       ' + widget.itemType + ', ' + widget.itemName + ', ' + widget.itemDateTime + ', ' + widget.itemCountdown.toString());
          if (widget.itemType == 'expiry') {
            setState(() {
              this.selectedItemIndex = 1;
            });
          }
          else if (widget.itemType == 'stock') {
            setState(() {
              this.selectedItemIndex = 2;
            });
          }
          else if (widget.itemType == 'to-do') {
            setState(() {
              this.selectedItemIndex = 3;
            });
          }
          else if (widget.itemType == 'to-buy') {
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
          log('longpress: ' + widget.itemType + ', ' + widget.itemName + ', ' + widget.itemDateTime + ', ' + widget.itemCountdown.toString());
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
        color: widget.itemType == 'expiry' ? Color(0xFFC88264)
              : widget.itemType == 'stock' ? Color(0xFF6B75E3)
              : widget.itemType == 'to-do' ? Color(0xFF7BB076)
              : widget.itemType == 'to-buy' ? Color(0xFFD86579)
              : Colors.blue,
        border: Border.all(
          width: 3,
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
                  widget.itemDateTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  widget.itemCountdown.toString() + ' days',
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
                  log('editing content');
                  setState(() {
                    isEditingContent = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
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
              child: Text(
                'delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 100.0,
              child: GestureDetector(
                onTap: () {
                  log('cancel');
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

class SecondRoute extends StatelessWidget {
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
                    onPressed: () {
                      // TODO: save the edited data
                      Navigator.pop(context);
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