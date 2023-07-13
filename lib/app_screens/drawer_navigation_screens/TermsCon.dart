import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../rest_api/ApiList.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

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
              child: SizedBox(
                height: 18,
                child: Image.asset(
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
            ], stops: const [
              0.0,
            ]),
            image: DecorationImage(
              image: const AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 0.0,
                        right: 0.0,
                        top: 20.0,
                      ),
                      child: Image.asset(
                        "images/tc_logo.png",
                        fit: BoxFit.fill,
                        height: 70,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      color: AppTheme().color_white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
          ),
        ));
  }
}
