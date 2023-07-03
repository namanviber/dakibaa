import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'ApiList.dart';
import 'TermsCon.dart';


class TermsConditionAgree extends StatefulWidget {
  @override
  TermsAgreeSettingPage createState() => TermsAgreeSettingPage();
}

class TermsAgreeSettingPage extends State<TermsConditionAgree> {
  AnimationController _controller;
  double screenHeight;
  double screenwidth;
  File _image;
  bool status = false;
  Map<String, dynamic> value;
  List<dynamic> listData;
  Map data;
  ProgressDialog pr;
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
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(220, 84, 85, 0.8),
              Color.fromRGBO(140, 53, 52, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Stack(
            children: <Widget>[
              profile_Page(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget profile_Page(BuildContext context) {
    return Container(

      alignment: Alignment.bottomCenter,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Terms &",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    ),
                    Text(
                      "Conditions",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2),
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
                                "images/agreement.png",
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
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Center(
                  child: head==null||Tc1==null||Tc2==null||Tc3==null||Tc4==null||Tc5==null?Text(""
                  ):Text(
                    "$head "" $Tc1 "" $Tc2 "" $Tc2 "" $Tc3 "" $Tc4 "" $Tc5",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Center(
                          child: Text(
                            "I have read and agree to the ",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600

                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600

                          ),
                        ),

                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: CustomSwitch(
                      activeColor: Colors.green,
                      value: status,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                  ),


                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsCondition()),
                    );
                  },
                  child: Center(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Center(
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "CONTINUE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20, letterSpacing: 2.0
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            "images/rightarrow.png",
                            fit: BoxFit.fill,
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  }
  Future getData() async {
    // _isProgressBarShown = true;
    http.Response response = await http
        .get(APIS.termsCondition);
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
      //  _isProgressBarShown = false;
    });

    /*Toast.show(""+listData.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);*/
  }
}
