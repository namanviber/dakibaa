import 'dart:io';

import 'package:flutter/material.dart';
import '../../profile_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../image_picker_handler.dart';
import '../authorization_screens/login_pagenew.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  ProfileScreenPage createState() => ProfileScreenPage();
}

class ProfileScreenPage extends State<EditProfilePage>
    with TickerProviderStateMixin, ImagePickerListener {
  late ImagePickerHandler imagePicker;
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  File? _image;
  bool? checkValue;
  var name, id, gender, mobile, dob,email,password, profile_pic;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
         /* lowerHalf(context),
          upperHalf(context),*/
          profile_Page(context),
        ],
      ),
    );
  }



/*  Widget upperHalf(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          child: Container(
            height: screenHeight / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(220, 84, 85, 1),
                Color.fromRGBO(140, 53, 52, 1)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ) ,
            child:  Container(
              margin: EdgeInsets.only(bottom: 220.0),
              child: Center(
                child: Text('PROFILE',
                  style: TextStyle(
                      fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),


    );
  }*/

  Widget profile_Page(BuildContext context) {

    return Column(
      children: <Widget>[
        Center(
          child: Container(

            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Card(
              margin: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 20.0),
              color: const Color.fromRGBO(245, 246, 251, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.only(left:10.0,right:10.0,top:30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 0.0,
                        top: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileUpdate()),
                              );
                            },
                            child: Center(
                              child: _image == null
                                  ? GestureDetector(
                                //  onTap: () => imagePicker.showDialog(context),
                                child: SizedBox(
                                    height: 90.0,
                                    width: 100,
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage: NetworkImage(
                                            "http://partyapp.v2infotech.net/resources/$profile_pic"),
                                        // backgroundColor: Colors.white,
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              40, 0, 0, 40),
                                          child: Image.asset(
                                            "images/edit.png",
                                            fit: BoxFit.fill,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                                  : Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                  // color: Colors.lightBlue,
                                  image: DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(

                      child: Container(

                        alignment: Alignment.topCenter,
                        child: Text(
                          "$name",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontSize: 20,

                              fontWeight: FontWeight.w400),
                        ),



                      ),
                    ),
                    Column(children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: const Divider(
                                color: Color.fromRGBO(140, 53, 52, 1),
                                height: 36,
                                thickness: 1,
                              )),
                        ),
                      ]),
                    ]),
                    const SizedBox(
                      height: 14,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text('NAME. -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $name",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text('PHONE NO. -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $mobile",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                 /*       SizedBox(
                          height: 14,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('EMAIL -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $email",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )*/
                 /*         SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('GENDER -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $gender",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('D.O.B -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $dob",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),*/
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text('PASSWORD -',
                                style: TextStyle(
                                    color: Color.fromRGBO(220, 84, 85, 1),
                                    fontFamily: "Raleway",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "    $password",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    getCredential();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log In First'),
          content: const Text('Please login first to check the Profile!!!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          id = sharedPreferences.getString("id");
         /* if(id=="")
          {
            Toast.show("" +"Please Login First", context,
                duration: Toast.lengthShort, gravity: Toast.bottom,);
            _ackAlert(context);
          }*/
          name = sharedPreferences.getString("name");
         /* gender = sharedPreferences.getString("gender");*/
          mobile = sharedPreferences.getString("mobile");
        /*  dob = sharedPreferences.getString("dob");
          email = sharedPreferences.getString("email");*/
          password = sharedPreferences.getString("password");
          profile_pic = sharedPreferences.getString("profile_pic");


        } else {
          name.clear();
          id.clear();
         /* gender.clear();*/
          mobile.clear();
         /* dob.clear();
          email.clear();*/
          password.clear();
          profile_pic.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
}
