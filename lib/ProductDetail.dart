import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProductDetail extends StatefulWidget {
  var data,image;
  ProductDetail({this.data,this.image});

  @override
  ScreenState createState() => ScreenState(data: data,image:image);
}

class ScreenState extends State<ProductDetail> {
  var data,image;

  ScreenState({this.data,this.image});
  ProgressDialog? pr;
  var id, count;
  SharedPreferences? sharedPreferences;
  List? listData;
  http.Response? response;
  Map? data1;
  double? screenHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 153, 153, 0.8),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(220, 84, 85, 0.8),
              Color.fromRGBO(140, 53, 52, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: new DecorationImage(
                      image: NetworkImage( "http://partyapp.v2infotech.net/resources/" +
                         image),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    data,
                    style: TextStyle(color: Colors.white, fontSize: 18,
                    wordSpacing: 2,
                    letterSpacing: 2),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
