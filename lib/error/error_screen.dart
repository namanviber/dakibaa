import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:partyapp/Colors/colors.dart';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.8),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("images/services_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          )),
      width : 300,
      height: 250,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Text("",
            ),
          ),
          Expanded(
            flex: 3,
            child: new Center(
              child: new Image.asset("images/error.png",height: 200,width: 200),
            ),
          ),

          Expanded(
              flex: 3,
              child: new Container(
                padding: EdgeInsets.only(top: 20),
                child: new Text("Error occured due to unknown reason. Please try again later.",
                  textAlign: TextAlign.center,maxLines: 3,
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: new ElevatedButton(
                  child: new Text('Back',
                    style: new TextStyle(
                      fontSize: 14 ,
                      height: 1.0 ,
                      color: Colors.white ,
                    ),
                  ),
                  onPressed: (){
//                    Navigator.pop(context);
                    Navigator.pop(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0)));
                  })
          ),
          new Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    ),
  );
}