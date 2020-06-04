import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String itemType;
  final String itemName;
  final String itemDateTime;
  final int itemCountdown;
  ItemWidget(
    {
      @required this.itemType,
      @required this.itemName,
      @required this.itemDateTime,
      @required this.itemCountdown,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          print(itemType + ', ' + itemName + ', ' + itemDateTime + ', ' + itemCountdown.toString());
        },
        child: new Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: 75.0,
          color: Colors.transparent,
          child: new Container(
            decoration: new BoxDecoration(
              color: itemType == 'expiry' ? Color(0xFFC88264)
                   : itemType == 'stock' ? Color(0xFF6B75E3)
                   : itemType == 'to-do' ? Color(0xFF7BB076)
                   : itemType == 'to-buy' ? Color(0xFFD86579)
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
                    itemName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        itemDateTime,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        itemCountdown.toString() + ' days',
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
    );

  }
}