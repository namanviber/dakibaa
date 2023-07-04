import 'dart:convert';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/common/shared_preferences.dart';
import 'package:partyapp/network/network.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:partyapp/app_screens/authorization_screens/signup_pagenew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';
import '../../Services.dart';
import '../../common/constant.dart';
import '../../forget_password.dart';
import '../../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme().color_black,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Dakibaa Logo
                Image.asset(
                  'images/dakiba_logo.png',
                  width: 300,
                  fit: BoxFit.cover,
                ),
                Container(
                    width: screenwidth * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppTheme().color_white,
                        borderRadius: BorderRadius.circular(50)),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        color: AppTheme().color_red,
                      ),
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        hintStyle: new TextStyle(
                            color: AppTheme().color_red,
                            fontFamily: 'Montserrat',
                            fontSize: 20),
                        hintText: "Username",
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 17, color: AppTheme().color_red),
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPass()),
                    );
                  },
                  child: SizedBox(
                    width: screenwidth,
                    child: Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          color: AppTheme().color_white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppTheme().color_red)),
                  child: GestureDetector(
                    onTap: () {
                      getData();
                    },
                    child: Center(
                      child: Text(
                        "Sign In".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: AppTheme().color_white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppTheme().color_red)),
                  child: GestureDetector(
                    onTap: () {
                      setGuest();
                      pr = new ProgressDialog(context,
                          type: ProgressDialogType.Normal);
                      pr.show();
                      NetworkConnection.check().then((intenet) async {
                        if (intenet != null && intenet) {
                          pr.hide();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Number_of_Person()));
                        } else {
                          pr.hide();
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => InternetConnection()));
                        }
                      });
                    },
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var returnData;

  Future<Map<String, dynamic>> getData() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    if (SignupValidation()) {
      NetworkConnection.check().then((intenet) async {
        if (intenet != null && intenet) {
          pr.show();
          final response = await http.post(Uri.parse(APIS.usersLogin), headers: {
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
            Toast.show("" + parsedJson['message'],
                duration: Toast.lengthShort, gravity: Toast.bottom,);
            //_onChanged(value);
            loginstatus = "signin";
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Number_of_Person()),
                (Route<dynamic> route) => false);
          } else {
            pr.hide();
            Toast.show("" + parsedJson['message'],
                duration: Toast.lengthShort, gravity: Toast.bottom,);
          }
          return parsedJson;
        } else {

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InternetConnection()));
        }
      });
    }
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
