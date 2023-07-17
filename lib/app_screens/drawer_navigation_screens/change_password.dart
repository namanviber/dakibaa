import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  @override
  bool status = false;
  String? _oldPasswordError;

  String? _passwordError;
  String? _confirmPasswordError;
  String? oldPassword;
  String? password;
  String? confirmPassword;
  final _formkey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool passwordVisible1 = true;
  bool passwordVisible2 = true;
  bool passwordVisible3 = true;
  late ProgressDialog pr;
  Map<String, dynamic>? value;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late SharedPreferences sharedPreferences;
  late var id;
  bool? checkValue;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                          width: 30,
                                          height: 20,
                                          child: Image.asset(
                                              "images/back_button.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: 0.0,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          bottom: 0.0),
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: AppTheme().colorWhite,
                                            //fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat-SemiBold",
                                            fontSize: 32),
                                      )),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _oldPasswordError == null ? 0 : 10,
                                      left: 40),
                                  child: Row(
                                    children: [
                                      Text(
                                        _oldPasswordError == null
                                            ? ""
                                            : _oldPasswordError!,
                                        style: TextStyle(
                                            color: AppTheme().colorWhite,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().colorWhite,
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: const EdgeInsets.only(
                                      left: 30.0, top: 8.0, right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                6),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      /* validator: (value){
                                    if(value.isEmpty){
                                      return "Enter old password";
                                    }
                                    else {
                                      return null;
                                    }
                                  },*/
                                      controller: oldPasswordController,
                                      onChanged: (values) {
                                        setState(() {
                                          oldPassword = values;
                                        });
                                      },
                                      obscureText: passwordVisible,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme().colorRed,
                                            fontSize: 18,
                                            fontFamily: "Montserrat-SemiBold"),
                                        hintText: "Old Password",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _passwordError == null ? 0 : 20,
                                      left: 40),
                                  child: Row(
                                    children: [
                                      Text(
                                        _passwordError == null
                                            ? ""
                                            : _passwordError!,
                                        style: TextStyle(
                                            color: AppTheme().colorWhite,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().colorWhite,
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: const EdgeInsets.only(
                                      left: 30.0, top: 8.0, right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                6),
                                    child: TextFormField(
                                      /*  validator: (value){
                                    if(value.isEmpty){
                                      return 'Enter new password';
                                    }

                                  },*/
                                      textAlign: TextAlign.center,
                                      controller: passwordController,
                                      onChanged: (values) {
                                        setState(() {
                                          password = values;
                                        });
                                      },
                                      obscureText: passwordVisible1,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passwordVisible1 =
                                                    !passwordVisible1;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible1
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme().colorRed,
                                            fontSize: 18,
                                            fontFamily: "Montserrat-SemiBold"),
                                        hintText: "New Password",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _confirmPasswordError == null
                                          ? 0
                                          : 20,
                                      left: 40),
                                  child: Row(
                                    children: [
                                      Text(
                                        _confirmPasswordError == null
                                            ? ""
                                            : _confirmPasswordError!,
                                        style: TextStyle(
                                            color: AppTheme().colorWhite,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().colorWhite,
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: const EdgeInsets.only(
                                      left: 30.0, top: 8.0, right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                13),
                                    child: TextFormField(
                                      /*validator: (value){
                                    if(value.isEmpty){
                                      return 'Please confirm your password';
                                    }
                                    if(value!=passwordController.text){
                                      return 'Password is not matching';
                                    }
                                  },*/
                                      controller: confirmPasswordController,
                                      onChanged: (values) {
                                        setState(() {
                                          confirmPassword = values;
                                        });
                                      },
                                      obscureText: passwordVisible2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passwordVisible2 =
                                                    !passwordVisible2;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme().colorRed,
                                            fontSize: 18,
                                            fontFamily: "Montserrat-SemiBold"),
                                        hintText: "Confirm New Password",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppTheme().colorRed,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: AppTheme().colorRed)),
                                    child: GestureDetector(
                                      onTap: () {
                                        changePassword(
                                            oldPasswordController.text,
                                            passwordController.text);
                                      },
                                      child: Center(
                                        child: Text(
                                          "Submit".toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 20,
                                              color: AppTheme().colorWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          id = sharedPreferences.getString("id");
        } else {
          id.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  bool ChangePasswordValidation() {
    setState(() {
      status = true;
    });

    _oldPasswordError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    if (oldPassword == "" || oldPassword == null) {
      setState(() {
        _oldPasswordError = 'Enter Old Password';
        status = false;
      });
    }
    if (password == "" || password == null) {
      setState(() {
        _passwordError = 'Enter New Password';
        status = false;
      });
    } else if (password!.length < 8) {
      setState(() {
        _passwordError = 'Enter minimum 8 characters';
        status = false;
      });
    }
    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Password not Match';
        status = false;
      });
    }
    return status;
  }

  var returnData;

  void changePassword(String oldpass, String newpass) async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Processing..", barrierDismissible: true);

    try {
      final response =
          await http.post(Uri.parse(APIS.changePassword), headers: {
        'Accept': 'application/json'
      }, body: {
        "id": id.toString(),
        "oldpassword": oldpass,
        "password": newpass,
      });

      print("Data:  ${Uri.parse(APIS.changePassword)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          setState(() {
            sharedPreferences.clear();
            sharedPreferences.setBool("check", false);
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AboutDakibaa()),
              (Route<dynamic> route) => false);
        } else {
          pr.close();
          Toast.show(
            parsedJson['message'],
            duration: Toast.lengthShort,
            gravity: Toast.bottom,
          );
        }
      } else {
        pr.close();
        throw Exception();
      }
    } on HttpException {
      Toast.show(
        "Internal Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } on FormatException {
      Toast.show(
        "Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } on TimeoutException {
      Toast.show(
        "Request time out Try again",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCredential();
    passwordVisible = true;
    passwordVisible1 = true;
    passwordVisible2 = true;
    passwordVisible3 = true;
  }
}
