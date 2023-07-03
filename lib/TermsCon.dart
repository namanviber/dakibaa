import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'ApiList.dart';

class TermsCondition extends StatefulWidget {
  @override
  TermsSettingPage createState() => TermsSettingPage();
}

class TermsSettingPage extends State<TermsCondition> {
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  bool _isProgressBarShown = true;
  bool hasData=false;
  File? _image;
  Map<String, dynamic>? value;
  List<dynamic>? listData;
  Map? data;
  ProgressDialog? pr;
  var head;
  var Tc1;
  var Tc2;
  var Tc3;
  var Tc4;
  var Tc5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
 /*   screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
*/
    // TODO: implement build
    return  Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
         // height: screenHeight,
          decoration: BoxDecoration(
              gradient: RadialGradient(

                  colors: [Colors.black.withOpacity(0.9)],
                  stops: [0.0, ]
              ),
              image: DecorationImage(
                image: AssetImage("images/services_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60,left: 20),
                child: new Row(
                  children: [
                    new InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: new Container(
                        width: 30,
                        height: 20,
                        child: Image.asset("images/back_button.png"),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                 /* crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,*/
                  children: <Widget>[


                    Center(
                      child: Container(

                          padding: EdgeInsets.only(
                            left: 0.0,
                            right: 0.0,
                            top: 20.0,
                          ),
                          child:Container(

                            child: Image.asset(
                              "images/tc_logo.png",
                              fit: BoxFit.fill,
                              height: 70,
                              width: 50,
                            ),
                          ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Terms &",
                        style: TextStyle(
                            fontSize: 30,
                            color: AppTheme().color_white,
                            fontFamily: "Montserrat-SemiBold",

                            ),
                      ),
                    ),
                    Text(
                      "Conditions",
                      style: TextStyle(
                          fontSize: 30,
                        color: AppTheme().color_white,
                        fontFamily: "Montserrat-SemiBold",),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              _isProgressBarShown?
              /*Padding(
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
              )*/
              Expanded(
                child: ListView(
                  children: [
                    itemLoading()
                  ],
                ),
              ):
              Container(
                height: 350,
                //alignment: Alignment.bottomCenter,
                child:  hasData == true ?Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),

                  child: new Container(
                    decoration: BoxDecoration(
                        color: AppTheme().color_white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(

                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Tc1==null||Tc2==null?Text(""
                              ):
                              Text(
                                "$Tc1 "" $Tc2 ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppTheme().color_red,
                                    fontFamily: "Montserrat-SemiBold"
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ):  Container(),
              ),
            ],
          ),
        ),
      );
  }


  Future getData() async {
     _isProgressBarShown = true;
    http.Response response = await http
        .get(APIS.getTC);
    var datatc = json.decode(response.body);
    setState(() {
      // listData = value["data"];
      print(datatc);
      head=datatc['data']['Heading']??'';
      Tc1=datatc['data']['Tc1']??'';
      Tc2=datatc['data']['Tc2']??'';
      Tc3=datatc['data']['Tc3']??'';
      Tc4=datatc['data']['Tc4']??'';
      Tc5=datatc['data']['Tc5']??'';

      print(head);
      print(Tc1);
        _isProgressBarShown = false;
    });
     hasData=true;
    /*Toast.show(""+listData.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);*/
  }

  Widget itemLoading() {
    return new Padding(
        padding: new EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: new Column(
              children: [
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 400.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),


              ],
            )
        )
    );
  }
}
