import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/app_screens/authorization_screens/changeForgotPassword.dart';
import 'package:dakibaa/app_screens/authorization_screens/signIn.dart';
import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:dakibaa/app_screens/home_screens/guestCount.dart';
import 'package:dakibaa/rest_api/ApiList.dart';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import '../../widgets/appButton.dart';

class OtpScreen extends StatefulWidget {
  String? type;
  String? otpphone;
  String mobile;

  OtpScreen({super.key, this.type, this.otpphone, required this.mobile});
  @override
  Otp createState() => Otp(type: type);
}

class Otp extends State<OtpScreen> {
  bool checkValue = false;
  Timer? _timer;
  int _start = 60;
  var temp = 0;
  var otp, otp1, resendotp, num;
  final otpController = TextEditingController();
  TextEditingController currController = TextEditingController();
  String baseUrl = 'http://partyapp.v2infotech.net/api';
  late ProgressDialog pr;
  late SharedPreferences sharedPreferences;
  Map<String, dynamic>? value;
  String? type;
  bool resendotpbool = false;

  Otp({this.type});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); //-> This part
    return Scaffold(
        backgroundColor: AppTheme().colorBlack,
        appBar: AppBar(
          scrolledUnderElevation: 1,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: AppBody(
            imgPath: "images/signup_background.jpg",
            body: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 100.0),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                                color: AppTheme().colorWhite,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontSize: 22),
                          )),
                      const SizedBox(height: 20.0),
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
                              'images/phone.png',
                            )),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'We sent a code',
                            style: TextStyle(
                                fontSize: 20,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat-SemiBold",
                                color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10.0, top: 8.0),
                          child: const Text(
                            'Enter the 4-digit code sent to your',
                            style: TextStyle(
                                fontSize: 15,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat-SemiBold",
                                color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10.0, top: 0.0),
                          child: const Text(
                            'Mobile Number',
                            style: TextStyle(
                                fontSize: 15,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat-SemiBold",
                                color: Colors.white),
                          )),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10.0, top: 5.0),
                          child: Text(
                            widget.otpphone ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat-SemiBold",
                                color: Colors.white),
                          )),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 5.0, left: 170.0, right: 170.0),
                        alignment: Alignment.center,
                        child: const Divider(
                          height: 2.0,
                          thickness: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                        child: Pinput(
                          controller: otpController,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: AppTheme().colorRed,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: AppTheme().colorWhite,
                            ),
                          ),
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                        ),
                      ),
                      AppButton(
                        onPressed: () {
                          if (otpController.text.isNotEmpty) {
                            sendOtp(otpController.text);
                          } else {
                            Toast.show(
                              "Please enter full otp",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                            );
                          }
                        },
                        title: "Continue",
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: (resendotpbool)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _start = 60;
                                    resendOtp();
                                    resendotpbool = false;
                                  });
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat-SemiBold",
                                      color: AppTheme().colorWhite),
                                ),
                              )
                            : Text(
                                "Resend Code in $_start",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat-SemiBold",
                                    color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ))));
  }

  sendOtp(String otp) async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Verifying..", barrierDismissible: true);

    try {
      if (widget.type == "forget") {
        final response = await http.post(Uri.parse(APIS.checkotp), headers: {
          'Accept': 'application/json'
        }, body: {
          "ActionType": "Checkotp",
          "otp": otp,
          "phone": widget.mobile,
        });

        print("Data:  ${Uri.parse(APIS.checkotp)}");

        if (response.statusCode == 200) {
          var parsedJson = json.decode(response.body);
          print("response body: $parsedJson");

          if (parsedJson['status'] == "1") {
            pr.close();
            value = parsedJson['data'];
            if (parsedJson["message"]['checkotp'] == "CORRECT OTP") {
              _timer!.cancel();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgetForm(number: widget.mobile)));
              Toast.show(
                "Otp Matched",
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
              );
            } else {
              Toast.show(
                "OTP doesn't match",
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
              );
            }
          } else {
            pr.close();
            Toast.show(
              parsedJson["message"]['accRegistered'],
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );
          }
        } else {
          pr.close();
          throw Exception();
        }
      } else {
        final response = await http.post(Uri.parse(APIS.otpAuth), headers: {
          'Accept': 'application/json'
        }, body: {
          "ActionType": type.toString(),
          "otp": otp,
          "phone": widget.mobile,
        });

        print("Data:  ${Uri.parse(APIS.otpAuth)}");
        print("body ${{
          "type": type.toString(),
          "Otp": otp,
          "phone": widget.mobile,
        }}");

        if (response.statusCode == 200) {
          var parsedJson = json.decode(response.body);
          print("response body: $parsedJson");

          if (parsedJson['status'] == "1") {
            pr.close();
            if (parsedJson["message"]['accRegistered'] ==
                "otp matched") {
              _timer!.cancel();
              value = parsedJson["message"];
              setState(() {
                _onChanged(true, value!);
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Number_of_Person()),
                      (Route<dynamic> route) => false);
              Toast.show(
                "Account Created Successfully",
                duration: Toast.lengthShort,
                gravity: Toast.bottom,
              );
            } else {
              Toast.show(
                "OTP doesn't match",
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
              );
            }
          } else {
            pr.close();
            Toast.show(
              parsedJson["message"]['accRegistered'],
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );
          }
        } else {
          pr.close();
          throw Exception();
        }
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

  resendOtp() async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Sending..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.resendOtp),
          headers: {'Accept': 'application/json'},
          body: {"number": widget.mobile});

      print("Data:  ${Uri.parse(APIS.resendOtp)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          String otp = parsedJson['message']
              .toString()
              .replaceAll("New otp send to your Mobile", "");
          setState(() {
            _start = 60;
            resendotpbool = false;
            widget.otpphone = otp;
          });
        } else {
          pr.close();
          Toast.show(
            parsedJson["message"],
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

  _onChanged(bool value, Map<String, dynamic> response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response["Name"]);
      sharedPreferences.setString("id", response["Id"].toString());
      sharedPreferences.setString("gender", response["Gender"]);
      sharedPreferences.setString("dob", response["DOB"]);
      sharedPreferences.setString("mobile", response["Mobile"]);
      sharedPreferences.setString("email", response["Mobile"]);
      sharedPreferences.setString("password", response["Password"]);
      sharedPreferences.setString("profile_pic", response["ProfilePic"]);
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(_start);
      setState(() {
        if (!resendotpbool) {
          _start--;
          if (_start == -1) {
            setState(() {
              resendotpbool = true;
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currController = otpController;
    startTimer();
  }
}
