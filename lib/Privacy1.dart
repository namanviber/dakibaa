import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'ApiList.dart';

class Privacy1 extends StatefulWidget {
  @override
  PrivacySettingPage createState() => PrivacySettingPage();
}

class PrivacySettingPage extends State<Privacy1> {
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  File? _image;
  Map<String, dynamic>? value;
  List<dynamic>? listData;
  Map? data;
  ProgressDialog? pr;
  String? head;
  String? head1;
  bool _isProgressBarShown = true;
  bool hasData=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    /*  screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;*/

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(220, 84, 85, 0.8),
            Color.fromRGBO(140, 53, 52, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "PRIVACY",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2),
                    ),
                  ),
                  Center(
                    child: Container(
                        padding: EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                          top: 20.0,
                        ),
                        child: Center(
                          child: Container(
                            child: Image.asset(
                              "images/lock.png",
                              fit: BoxFit.fill,
                              height: 90,
                              width: 90,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            /*isProgressBarShown?
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: new Center(
                    child: new Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Center(
                          child: Container(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Row(children: <Widget>[
                                new CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                                Text("    Loading...", style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold,
                                    color: Colors.black),),
                              ],),
                            ),


                          ),
                        )
                    )
                ),
              ),
            ):
             WebviewScaffold(
                url: new Uri.dataFromString(head, mimeType: 'text/html').toString(),
              ),
            */
          ],
        ),
      ),
    );
  }


  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http
        .get(APIS.privacy1);
    head = response.body??'';
    setState(() {
     print(head);
      _isProgressBarShown = false;
    });
   // hasData=true;
  }
}
