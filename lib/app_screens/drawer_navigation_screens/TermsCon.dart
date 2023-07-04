import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../rest_api/ApiList.dart';

class TermsCondition extends StatefulWidget {
  @override
  TermsSettingPage createState() => TermsSettingPage();
}

class TermsSettingPage extends State<TermsCondition> {
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  bool _isProgressBarShown = true;
  bool hasData = false;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: new Container(
                height: 18,
                child: new Image.asset(
                  "images/back_button.png",
                ),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Colors.black.withOpacity(0.9)
            ], stops: [
              0.0,
            ]),
            image: DecorationImage(
              image: AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 0.0,
                        right: 0.0,
                        top: 20.0,
                      ),
                      child: Container(
                        child: Image.asset(
                          "images/tc_logo.png",
                          fit: BoxFit.fill,
                          height: 70,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 30,
                        color: AppTheme().color_white,
                        fontFamily: "Montserrat-SemiBold",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            _isProgressBarShown
                ? itemLoading()
                : Container(
              child: hasData == true
                  ? Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 50),
                child: new Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      color: AppTheme().color_white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SingleChildScrollView(
                      child: Text(
                        "$Tc1.\n\n$Tc2.\n\n$Tc3.\n\n$Tc4.\n\n$Tc5.",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppTheme().color_red,
                            fontFamily: "Montserrat-SemiBold"),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http.get(Uri.parse(APIS.getTC));
    var datatc = json.decode(response.body);
    setState(() {
      // listData = value["data"];
      print(datatc);
      head = datatc['data']['Heading'] ?? '';
      Tc1 = datatc['data']['Tc1'] ?? '';
      Tc2 = datatc['data']['Tc2'] ?? '';
      Tc3 = datatc['data']['Tc3'] ?? '';
      Tc4 = datatc['data']['Tc4'] ?? '';
      Tc5 = datatc['data']['Tc5'] ?? '';

      print(head);
      print(Tc1);
      _isProgressBarShown = false;
    });
    hasData = true;
    /*Toast.show(""+listData.toString(), context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
  }

  Widget itemLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
          ),
        ));
  }
}
