import 'dart:async';
import 'dart:io';
import 'package:dakibaa/widgets/appButton.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../rest_api/ApiList.dart';
import '../../widgets/appBody.dart';
import '../../widgets/appTextField.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'otpScreen.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPass();
  }
}

class _ForgotPass extends State<ForgotPass> {
  late SharedPreferences sharedPreferences;
  bool? checkValue;
  Map<String, dynamic>? value;
  final _formkey = GlobalKey<FormState>();
  final contactController = TextEditingController();
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); //-> This part
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: AppTheme().colorWhite,
                      // fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      fontSize: 22),
                ),
                const SizedBox(height: 40.0),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 0.3)),
                  child: Container(
                    margin: const EdgeInsets.all(30.0),
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset(
                      'images/forgot.png',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 8.0),
                    child: const Text(
                      'Enter the Phone Number',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10.0, top: 0, bottom: 0),
                    child: const Text(
                      'associated with your account',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, left: 170.0, right: 170.0),
                  alignment: Alignment.center,
                  child: const Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                ),
                AppTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your contact';
                    } else if (value.length != 10) {
                      return "contact must be of 10 digits";
                    } else {
                      return null;
                    }
                  },
                  controller: contactController,
                  hinttext: "Contact No.",
                  isphone: true,
                ),
                AppButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        // _formkey.currentState!.save();
                        // setState(() {});
                        verifyData();
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

  verifyData() async {
    ToastContext().init(context); //-> This part
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Processing..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.checkRegistration),
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "ActionType": "registeredUser",
            "phone": contactController.text
          });

      print("Data: ${Uri.parse(APIS.checkRegistration)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          if (parsedJson['message']
              .toString()
              .contains("Mobile no is registered")) {
            String otp = parsedJson['message']
                .toString()
                .replaceAll("Mobile no is registered", "");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        type: 'forget',
                        mobile: contactController.text,
                        otpphone: otp,
                      )),
            );
          } else {
            Toast.show(
              parsedJson['message'],
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );
          }
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
}
