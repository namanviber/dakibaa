import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/rest_api/ApiList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/app_screens/home_screens/number_of_person.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'login_pagenew.dart';

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
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  TextEditingController currController = TextEditingController();
  String baseUrl = 'http://partyapp.v2infotech.net/api';
  late ProgressDialog pr;
  late SharedPreferences sharedPreferences;
  Map<String, dynamic>? value;
  FocusNode textFirstFocusNode = FocusNode();
  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourthFocusNode = FocusNode();
  String? type;
  bool resendotpbool = false;

  Otp({this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.black.withOpacity(0.9)], stops: const [0.0]),
            image: DecorationImage(
              image: const AssetImage("images/signup_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 30,
                          height: 20,
                          child: Image.asset("images/back_button.png"),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          color: AppTheme().color_white,
                          //fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: 22),
                    )),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 8.0),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 0.0),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10.0, top: 5.0),
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
                  margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Pinput(
                          controller: controller1,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: AppTheme().color_red,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: AppTheme().color_white,
                            ),
                          ),
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                        ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Flexible(
//                               child: Container(
//                                 //margin: EdgeInsets.fromLTRB(15,0,10,0),
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(right: 0, left: 0),
//                                   child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           color: AppTheme().color_white,
//                                           border: Border.all(
//                                               width: 1.0,
//                                               color: const Color.fromRGBO(
//                                                   0, 0, 0, 0.1)),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(100.0))),
//                                       child: TextFormField(
//                                         cursorColor: AppTheme().color_red,
//                                         decoration: const InputDecoration(
//                                             border: InputBorder.none),
//                                         keyboardType: TextInputType.phone,
//                                         textInputAction: TextInputAction.next,
//                                         onFieldSubmitted: (String value) {
//                                           FocusScope.of(context).requestFocus(
//                                               textSecondFocusNode);
//                                         },
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(1),
//                                         ],
//                                         enabled: true,
//                                         controller: controller1,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 24.0,
//                                             color: AppTheme().color_red,
//                                             fontFamily: "Montserrat-SemiBold"),
//                                       )),
//                                 ),
// //                                PinInputTextField(
// //                                  pinLength: 4,
// //                                  decoration: UnderlineDecoration(
// //                                      textStyle: TextStyle(
// //                                          color: Colors.black)),
// //                                ),
//                               ),
//                             ),
//                             Flexible(
//                               child: Container(
//                                 // margin: EdgeInsets.fromLTRB(10,0,10,0),
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(right: 0, left: 0),
//                                   child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           color: AppTheme().color_white,
//                                           border: Border.all(
//                                               width: 1.0,
//                                               color: const Color.fromRGBO(
//                                                   0, 0, 0, 0.1)),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(100.0))),
//                                       child: TextFormField(
//                                         cursorColor: AppTheme().color_red,
//                                         decoration: const InputDecoration(
//                                             border: InputBorder.none),
//                                         keyboardType: TextInputType.phone,
//                                         focusNode: textSecondFocusNode,
//                                         textInputAction: TextInputAction.next,
//                                         onFieldSubmitted: (String value) {
//                                           FocusScope.of(context)
//                                               .requestFocus(textThirdFocusNode);
//                                         },
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(1),
//                                         ],
//                                         enabled: true,
//                                         controller: controller2,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 24.0,
//                                             color: AppTheme().color_red,
//                                             fontFamily: "Montserrat-SemiBold"),
//                                       )),
//                                 ),
// //                                ),
//                               ),
//                             ),
//                             Flexible(
//                               child: Container(
//                                 // margin: EdgeInsets.fromLTRB(10,0,10,0),
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(right: 0, left: 0),
//                                   child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                         color: AppTheme().color_white,
//                                         border: Border.all(
//                                             width: 1.0,
//                                             color: const Color.fromRGBO(
//                                                 0, 0, 0, 0.1)),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(200.0)),
//                                       ),
//                                       child: TextFormField(
//                                         cursorColor: AppTheme().color_red,
//                                         decoration: const InputDecoration(
//                                             border: InputBorder.none),
//                                         keyboardType: TextInputType.phone,
//                                         focusNode: textThirdFocusNode,
//                                         textInputAction: TextInputAction.next,
//                                         onFieldSubmitted: (value) {
//                                           FocusScope.of(context).requestFocus(
//                                               textFourthFocusNode);
//                                         },
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(1),
//                                         ],
//                                         enabled: true,
//                                         controller: controller3,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 24.0,
//                                             color: AppTheme().color_red,
//                                             fontFamily: "Montserrat-SemiBold"),
//                                       )),
//                                 ),
// //                                PinInputTextField(
// //                                  pinLength: 4,
// //                                  decoration: UnderlineDecoration(
// //                                      textStyle: TextStyle(
// //                                          color: Colors.black)),
// //                                ),
//                               ),
//                             ),
//                             Flexible(
//                               child: Container(
//                                 //  margin: EdgeInsets.fromLTRB(10,0,15,0),
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(right: 0, left: 0),
//                                   child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           color: AppTheme().color_white,
//                                           border: Border.all(
//                                               width: 1.0,
//                                               color: const Color.fromRGBO(
//                                                   0, 0, 0, 0.1)),
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(100.0))),
//                                       child: TextFormField(
//                                         cursorColor: AppTheme().color_red,
//                                         decoration: const InputDecoration(
//                                             border: InputBorder.none),
//                                         keyboardType: TextInputType.phone,
//                                         focusNode: textFourthFocusNode,
//                                         textInputAction: TextInputAction.done,
//                                         inputFormatters: [
//                                           LengthLimitingTextInputFormatter(1),
//                                         ],
//                                         enabled: true,
//                                         controller: controller4,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 24.0,
//                                             color: AppTheme().color_red,
//                                             fontFamily: "Montserrat-SemiBold"),
//                                       )),
//                                 ),
// //                                PinInputTextField(
// //                                  pinLength: 4,
// //                                  decoration: UnderlineDecoration(
// //                                      textStyle: TextStyle(
// //                                          color: Colors.black)),
// //                                ),
//                               ),
//                             ),
//                           ],
//                         ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppTheme().color_red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppTheme().color_red)),
                    child: GestureDetector(
                      onTap: () {
                        if (controller1.text.isNotEmpty) {
                          // &&
                          // controller2.text.isNotEmpty &&
                          // controller3.text.isNotEmpty &&
                          // controller4.text.isNotEmpty
                          // sendOtp(controller1.text +
                          //     controller2.text +
                          //     controller3.text +
                          //     controller4.text);
                          sendOtp(controller1.text);
                        } else {
                          Toast.show(
                            "Please enter full otp",
                            duration: Toast.lengthLong,
                            gravity: Toast.top,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          "Continue".toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: AppTheme().color_white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: (resendotpbool)
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _start = 60;
                              reSendOtp();
                              resendotpbool = false;
                            });
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat-SemiBold",
                                color: AppTheme().color_red),
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
            )),
      ),
    ));
  }

  void sendOtp(String otp) async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Verifying..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.otpAuth), headers: {
        'Accept': 'application/json'
      }, body: {
        "type": type.toString(),
        "otp": otp,
        "Mobile": widget.mobile,
      });

      print("Data:  ${Uri.parse(APIS.otpAuth)}");
      print("body ${{
        "type": type.toString(),
        "otp": otp,
        "Mobile": widget.mobile,
      }}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          value = parsedJson['data'];
          if (type == "forget") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false);
          } else {

            if (parsedJson["message"]['accRegistered'] == "otp matched") {
              _timer!.cancel();
              setState(() {
                _onChanged(true, value);
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const Number_of_Person()),
                  (Route<dynamic> route) => false);
            } else {
              Toast.show(
                "OTP doesn't match",
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
              );
            }
          }
        } else {
          pr.close();
          Toast.show(
            parsedJson["message"]['accRegistered'],
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
        }
      }
      else{
        pr.close();
        throw Exception();
      }
    } on HttpException {
      Toast.show(
        "Internal Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.top,
      );
    } on FormatException {
      Toast.show(
        "Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.top,
      );
    } on TimeoutException {
      Toast.show(
        "Request time out Try again",
        duration: Toast.lengthLong,
        gravity: Toast.top,
      );
    }
  }

//   Future<Map<String, dynamic>> sendOtp(String otp) async {
//     final response = await http.post(Uri.parse(APIS.otpAuth), headers: {
//       'Accept': 'application/json'
//     }, body: {
//       "type": type.toString(),
//       "otp": controller1.text +
//           controller2.text +
//           controller3.text +
//           controller4.text,
//       "Mobile": widget.mobile,
//     });
//
//
//     print({
//       "type": type.toString(),
//       "otp": controller1.text +
//           controller2.text +
//           controller3.text +
//           controller4.text,
//       "Mobile": widget.mobile,
//     });
//     print("response: $response");
//     var parsedJson = json.decode(response.body);
//     print("response: $parsedJson");
//
//     if (parsedJson['status'] == "1") {
//       // pr.close();
//       value = parsedJson['data'];
// /*
//       Toast.show(parsedJson['message'], context,
//           duration: Toast.lengthLong, gravity: Toast.bottom,);*/
//       _timer!.cancel();
//       if (type == "forget") {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const LoginPage()),
//             (Route<dynamic> route) => false);
//       } else {
//         setState(() {
//           _onChanged(true, value);
//         });
//         // Navigator.of(context).pushNamedAndRemoveUntil('/screen2', (Route<dynamic> route) => false);
//
//         if (parsedJson['status']["message"]['accRegistered'] == "otp matched") {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => Number_of_Person()),
//               (Route<dynamic> route) => false);
//         } else {
//           Toast.show(
//             parsedJson['status']["message"]['accRegistered'],
//             duration: Toast.lengthShort,
//             gravity: Toast.bottom,
//           );
//         }
//       }
//
// /*  Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );*/
//     } else {
//       pr.close();
//       Toast.show(
//         parsedJson['status']["message"]['accRegistered'],
//         duration: Toast.lengthLong,
//         gravity: Toast.bottom,
//       );
//     }
//     return parsedJson;
//   }

  Future<Map<String, dynamic>> reSendOtp() async {
    sharedPreferences = await SharedPreferences.getInstance();
    num = sharedPreferences.getString("number");
    // pr = ProgressDialog(
    //   context: context,
    // );
    // pr.show(msg: "Loading..", barrierDismissible: true);
    String myUrl = "$baseUrl/party/User/resendOtp";
    final response = await http.post(Uri.parse(myUrl),
        headers: {'Accept': 'application/json'}, body: {"number": num});

    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    if (parsedJson['status'] == "1") {
      // pr.close();
      // temp = 1;
      /* Toast.show(parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
      resendotp = parsedJson['message'];
      otp1 = resendotp.split(' ')[3].split('').reversed.join();
    } else {
      // pr.close();
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    }
    return parsedJson;
  }

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response!["Name"]);
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
    controller1.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currController = controller1;
    // receiveMsg();
    startTimer();
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check")!;
      if (checkValue != null) {
        if (checkValue) {
//          name = sharedPreferences.getString("name");
//          id = sharedPreferences.getString("id");
//          gender = sharedPreferences.getString("gender");
//          mobile = sharedPreferences.getString("mobile");
//          city = sharedPreferences.getString("city");
//          profile_pic = sharedPreferences.getString("profile_pic");
          otp = sharedPreferences.getString("otp");
          otp1 = otp.split(' ')[3].split('').reversed.join();
        } else {
          otp.clear();

          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
}
