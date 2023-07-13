import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';import 'package:shimmer/shimmer.dart';

import '../../rest_api/ApiList.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  PrivacySettingPage createState() => PrivacySettingPage();
}

class PrivacySettingPage extends State<Privacy> {
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  File? _image;
  Map<String, dynamic>? value;
  List<dynamic>? listData;
  Map? data;
  ProgressDialog? pr;
  var head;
  bool _isProgressBarShown = true;
  bool hasData=false;

  @override
  void initState() {
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
              gradient: RadialGradient(

                  colors: [Colors.black.withOpacity(0.9)],
                  stops: const [0.0, ]
              ),
              image: DecorationImage(
                image: const AssetImage("images/services_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 70,),
                    Center(
                      child: Center(
                        child: Image.asset(
                          "images/privacy_logo.png",
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Privacy",
                        style: TextStyle(
                            fontSize: 30,
                            color: AppTheme().color_white,
                            fontFamily: "Montserrat-SemiBold",
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                    decoration: BoxDecoration(
                        color: AppTheme().color_white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: SingleChildScrollView(
                        child: Text(
                          "We are committed to protecting and respecting your privacy. This policy (together with our website and mobile application terms and conditions that apply to your use of our website) sets in place the fundamentals based on which any personal data we collect from you or that you provide us, will be processed. Please read the following points carefully to understand our views and practices regarding your personal data and how we will treat it.",
                          style: TextStyle(
                              fontSize: 17,
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
    http.Response response = await http
        .get(Uri.parse(APIS.privacy));
    var datatc = json.decode(response.body);
    setState(() {
      head=datatc['data']['Heading']??'';
      _isProgressBarShown = false;
    });
     hasData=true;
  }

  Widget itemLoading() {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 400.0,
                          decoration: const BoxDecoration(
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
