import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dakibaa/app_screens/authorization_screens/login_pagenew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_screens/drawer_navigation_screens/ContactUs.dart';
import 'app_screens/drawer_navigation_screens/Privacy.dart';
import 'app_screens/drawer_navigation_screens/TermsCon.dart';
import 'app_screens/drawer_navigation_screens/change_password.dart';
import 'app_screens/drawer_navigation_screens/faq_screen.dart';

class PartySetting extends StatefulWidget {
  const PartySetting({super.key});

  @override
  PartySettingPage createState() => PartySettingPage();
}

class PartySettingPage extends State<PartySetting> {
  late SharedPreferences sharedPreferences;
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  File? _image;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(220, 84, 85, 0.8),
            Color.fromRGBO(140, 53, 52, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: <Widget>[
            pageTitle(context),
            profile_Page(context),
          ],
        ),
      ),
    );
  }

  Widget pageTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  right: 0.0,
                  top: 20.0,
                ),
                child: Center(
                  child: Image.asset(
                    "images/gear.png",
                    fit: BoxFit.fill,
                    height: 80,
                    width: 80,
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "SETTING",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

/*
  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(220, 84, 85, 1),
          Color.fromRGBO(140, 53, 52, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }
*/

  Widget profile_Page(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 160, 0, 0),
      alignment: Alignment.bottomCenter,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaqScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/faqs.png",
                            fit: BoxFit.fill,
                            height: 30,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: const Text(
                        "FAQS",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 4.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsCondition()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/terms.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: const Text(
                        "T&C",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Privacy()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/LOCK_1.png",
                            fit: BoxFit.contain,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: const Text(
                        "Privacy",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/password.png",
                            fit: BoxFit.contain,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUs()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/phonesetting.png",
                            fit: BoxFit.contain,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  logOut();
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: 55,
                        width: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Image.asset(
                            "images/logout.png",
                            fit: BoxFit.contain,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
    });
    //Navigator.of(context).pop();
    //Navigator.popUntil(context, ModalRoute.withName('/'));
    //Navigator.pop(context,true);// It worked for me instead of above line
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstScreen()),);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }
}
