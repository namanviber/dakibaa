import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appButton.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';
import '../../widgets/appTextField.dart';
import 'signIn.dart';

class ForgetForm extends StatefulWidget {
  String number;
  ForgetForm({super.key, required this.number});
  @override
  _ForgetForm createState() => _ForgetForm(number: number);
}

class _ForgetForm extends State<ForgetForm> {
  String? number;
  _ForgetForm({this.number});
  @override
  final new_PasswordController = TextEditingController();
  final confirmNew_PasswordController = TextEditingController();
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  final _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AppBody(
        imgPath: "images/services_background.jpg",
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 100.0, bottom: 15.0),
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: 22),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 20.0),
                    child: Text(
                      'Create a new and unique password',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppTheme().colorWhite,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat"),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 0.0),
                    child: Text(
                      'for your account',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppTheme().colorWhite,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat"),
                    )),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 170.0,
                    right: 170.0,
                  ),
                  alignment: Alignment.center,
                  child: const Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formkey,
                  child: Column(children: <Widget>[
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
                          } else if (!value.contains(RegExp(r'[#?!@$%^&*-]'))) {
                            return "Password should contain Special character";
                          } else {
                            return null;
                          }
                        },
                        controller: new_PasswordController,
                        hinttext: "Password",
                        ispass: true),
                    AppTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != new_PasswordController.text) {
                          return 'Password is not matching';
                        }
                        return null;
                      },
                      controller: confirmNew_PasswordController,
                      hinttext: "Confirm Password",
                      ispass: true,
                    ),
                  ]),
                ),
                AppButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        forgetPassword();
                      }
                    },
                    title: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgetPassword() async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Processing..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.forgetPassword),
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "number": number.toString(),
            "password": new_PasswordController.text
          });

      print("Data: ${Uri.parse(APIS.forgetPassword)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);
          Toast.show(
            "Password Changed Successfully",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
        } else {
          pr.close();
          Toast.show(
            "Password Not Updated",
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
}
