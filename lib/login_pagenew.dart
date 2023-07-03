import 'dart:convert';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/about_dakibaa.dart';
import 'package:partyapp/common/shared_preferences.dart';
import 'package:partyapp/network/network.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:partyapp/paytm_screen.dart';
import 'package:partyapp/signup_pagenew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:party_app/forget_password.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import 'ApiList.dart';
import 'Services.dart';
import 'common/constant.dart';
import 'forget_password.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  double? screenHeight;
  double? screenwidth;
  String? usernameError, passwordError;
  String? password, username;
  bool checkValue = false;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  late SharedPreferences sharedPreferences;
  bool passwordVisible1 = true;
  final _formkey = GlobalKey<FormState>();
  bool status = false;
  bool SignupValidation() {
    setState(() {
      status = true;
    });

    passwordError = null;
    usernameError = null;
    if (username == "" || username == null) {
      setState(() {
        usernameError = 'Enter Username';
        status = false;
      });
    }
    if (password == "" || password == null) {
      setState(() {
        passwordError = 'Enter Password';
        status = false;
      });
    }
    if (password!.length < 8) {
      setState(() {
        passwordError = 'Enter minimum 8 characters';
        status = false;
      });
    }

    return status;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme().color_black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: [
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenwidth,
                  height: MediaQuery.of(context).size.height / 1.04,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.black,
                        Colors.black,
                      ], stops: [
                        0.0,
                        1,
                        1
                      ]),
                      image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 100,
                        child: Center(
                            child: Image.asset(
                          'images/dakiba_logo.png',
                          width: 300,
                          fit: BoxFit.cover,
                        )),
                      ),
                      /*Padding(
                            padding: const EdgeInsets.only(left:0.0,top: 12.0),
                            child: Text("DAKIBA",
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 1
                              ),),
                          ),*/
                      Padding(
                        padding: EdgeInsets.only(
                            top: usernameError == null
                                ? 0
                                : MediaQuery.of(context).size.height / 10,
                            left: 60),
                        child: new Container(
                            child: new Row(
                          children: [
                            Text(
                              usernameError == null ? "" : usernameError!,
                              style: TextStyle(
                                  color: AppTheme().color_white, fontSize: 15),
                            ),
                          ],
                        )),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 50.0, top: 8, right: 50.0),
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppTheme().color_white,
                                borderRadius: BorderRadius.circular(50)),
                            //margin: EdgeInsets.only(left: 20.0,top: MediaQuery.of(context).size.height/15,right: 20.0),

                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 17),
                                /* validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },*/
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                  });
                                },
                                cursorColor: AppTheme().color_red,
                                controller: usernameController,
                                textAlign: TextAlign.center,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  hintStyle: new TextStyle(
                                      color: AppTheme().color_red,
                                      fontFamily: 'Montserrat',
                                      fontSize: 20),
                                  hintText: "Username",
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: passwordError == null ? 10 : 10, left: 60),
                        child: new Container(
                            child: new Row(
                          children: [
                            Text(
                              passwordError == null ? "" : passwordError!,
                              style: TextStyle(
                                  color: AppTheme().color_white, fontSize: 15),
                            ),
                          ],
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 8.0, right: 50.0),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: AppTheme().color_white,
                              borderRadius: BorderRadius.circular(50)),
                          //height: 50,
                          /*margin: EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0),*/
                          child: Padding(
                            padding: const EdgeInsets.only(left: 48),
                            child: TextFormField(
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 17),
                              /* validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },*/
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              cursorColor: AppTheme().color_red,
                              controller: passwordController,
                              textAlign: TextAlign.center,
                              obscureText: passwordVisible1,
                              decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible1 = !passwordVisible1;
                                      });
                                    },
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      passwordVisible1
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppTheme().color_red,
                                    )),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                hintStyle: new TextStyle(
                                    color: AppTheme().color_red,
                                    fontFamily: 'Montserrat',
                                    fontSize: 20),
                                hintText: "Password",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 13.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPass()),
                              );
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Montserrat',
                                  color: AppTheme().color_white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, right: 110, left: 110),
                        child: GestureDetector(
                          onTap: () {
                            /*if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            setState(() {});
                            getData();
                          }*/
                            getData();
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppTheme().color_red,
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: AppTheme().color_red)),
                              //margin: EdgeInsets.only(top: 5.0,left: 80,right: 80),
                              child: Center(
                                child: Text(
                                  "Sign In".toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20,
                                      color: AppTheme().color_white),
                                ),
                              )

                              /*ButtonTheme(

                              minWidth: 360.0,
                              child: RaisedButton(
                                  color: AppTheme().color_red,
                                  disabledColor: AppTheme().color_red,
                                  child: Text("Sign In".toUpperCase(),
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 17,letterSpacing: 2),),
                                  onPressed: () {


                                    if (_formkey.currentState.validate()) {
                                      _formkey.currentState.save();
                                      setState(() {});
                                      getData();
                                    }
                                        if (_formkey.currentState.validate()) {
                                    _formkey.currentState.save();
                                    setState(() {});
                                    UsernameController.text;
                                    UserPasswordController.text;
                                  }else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  }

                                  },
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                              ),
                            ),*/
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 90, left: 90),
                        child: GestureDetector(
                          onTap: () {
                            setGuest();
                            pr = new ProgressDialog(context,
                                type: ProgressDialogType.Normal);
                            pr.show();
                            NetworkConnection.check().then((intenet) async {
                              if (intenet != null && intenet) {
                                pr.hide();

                                /*setState(() {
                                   name="Guest";
                                 });*/

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Services()));
                              } else {
                                pr.hide();
                                Navigator.of(context).push(PageTransition(
                                    type: PageTransitionType.custom,
                                    child: InternetConnection(),
                                    duration: Duration(milliseconds: 0)));
                              }
                            });
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppTheme().color_red,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: AppTheme().color_red)),
                            //margin: EdgeInsets.only(top: 5.0,left: 80,right: 80),
                            child: Center(
                              child: Text(
                                "Guest Sign In".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    color: AppTheme().color_white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: Text(
                              "New User ? SignUp",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  var returnData;

  Future<Map<String, dynamic>> getData() async {
    //  print(myController1.text);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    // print(token);
    if (SignupValidation()) {
      NetworkConnection.check().then((intenet) async {
        if (intenet != null && intenet) {
          pr.show();
          final response = await http.post(APIS.usersLogin, headers: {
            'Accept': 'application/json'
          }, body: {
            "username": usernameController.text,
            "password": passwordController.text
          });
          print(response.body);
          var parsedJson = json.decode(response.body);
          value = parsedJson['data'];
          print("Status = " + parsedJson['status']);
          if (parsedJson['status'] == "1") {
            pr.hide();
            new SharedPreferencesClass().setloginstatus(true);
            sharedPreferences = await SharedPreferences.getInstance();
            if (mounted) {
              setState(() {
                _onChanged(true, value);
                sharedPreferences.setString("email", value!["Mobile"]);
              });
            }
            Toast.show("" + parsedJson['message'], context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            //_onChanged(value);
            loginstatus = "signin";
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Number_of_Person()),
                (Route<dynamic> route) => false);
          } else {
            pr.hide();
            Toast.show("" + parsedJson['message'], context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
          return parsedJson;
        } else {
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.custom,
              child: InternetConnection(),
              duration: Duration(milliseconds: 0)));
        }
      });
    }

    /* final response = await http.post(APIS.usersLogin,
        headers: {'Accept': 'application/json'},
        body: {"username": usernameController.text,
          "password": passwordController.text});
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
      new SharedPreferencesClass().setloginstatus(true);
      sharedPreferences = await SharedPreferences.getInstance();
      if(mounted) {
        setState(() {
          _onChanged(true, value);
          sharedPreferences.setString("email", value["Mobile"]);
        });
      }
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      //_onChanged(value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    }

    return parsedJson;*/
    return returnData;

  }

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response!["Name"]);
      sharedPreferences.setString("id", response["Id"].toString());
      /* sharedPreferences.setString("gender", response["Gender"]);
      sharedPreferences.setString("dob", response["DOB"]);*/
      sharedPreferences.setString("mobile", response["Mobile"]);

      sharedPreferences.setString("password", response["Password"]);
      sharedPreferences.setString("profile_pic", response["ProfilePic"]);
      profile_pic = response["ProfilePic"];
      sharedPreferences.commit();
    });
  }

  setGuest() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
      sharedPreferences.setBool("check", true);
      sharedPreferences.setString("id", "");
      loginstatus = "guest";
    });
  }

  @override
  void initState() {
    passwordVisible1 = true;
    //getstatus();
  }

  void getstatus() async {
    bool loginstatus = await SharedPreferencesClass().getloginstatus();
    loginstatus == true
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()))
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}
