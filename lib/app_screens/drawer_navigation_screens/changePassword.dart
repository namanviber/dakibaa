import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appTextField.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';
import '../../widgets/appButton.dart';

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
  String? oldPassword;
  String? password;
  String? confirmPassword;
  final _formkey = GlobalKey<FormState>();
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
          backgroundColor: AppTheme().colorBlack,
          appBar: AppBar(
            scrolledUnderElevation: 1,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: AppBody(
            imgPath: "images/services_background.jpg",
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: 0.0, top: 200, bottom: 30.0),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                  color: AppTheme().colorWhite,
                                  //fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat-SemiBold",
                                  fontSize: 27),
                            )),
                      ),
                      AppTextField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter old password";
                            } else {
                              return null;
                            }
                          },
                          controller: oldPasswordController,
                          hinttext: "Old Password",
                          ispass: true),
                      AppTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else if (value.length < 8) {
                              return "Password range 8 - 15 digits";
                            } else if (value.length > 16) {
                              return "Password range 8 - 15 digits";
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return "Password should contain upper character";
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return "Password should contain digit";
                            } else if (!value.contains(RegExp(r'[a-z]'))) {
                              return "Password should contain lower chracter";
                            } else if (!value
                                .contains(RegExp(r'[#?!@$%^&*-]'))) {
                              return "Password should contain Special character";
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          hinttext: "New Password",
                          ispass: true),
                      AppTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Password is not matching';
                            }
                            return null;
                          },
                          controller: confirmPasswordController,
                          hinttext: "Confirm New Password",
                          ispass: true),
                      AppButton(
                          onPressed: () {
                            changePassword(oldPasswordController.text,
                                passwordController.text);
                          },
                          title: "Submit"),
                    ],
                  ),
                ],
              ),
            ),
          )),
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

  changePassword(String oldpass, String newpass) async {
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
            duration: Toast.lengthLong,
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
  }
}
