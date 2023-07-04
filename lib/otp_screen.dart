import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/home_page.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sms/sms.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'app_screens/authorization_screens/login_pagenew.dart';

class OtpScreen extends StatefulWidget {
  String? type;

  OtpScreen({this.type});
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
  TextEditingController currController = new TextEditingController();
  String baseUrl = 'http://partyapp.v2infotech.net/api';
  late ProgressDialog pr;
  late SharedPreferences sharedPreferences;
  Map<String, dynamic>? value;
  FocusNode textFirstFocusNode = new FocusNode();
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  FocusNode textFourthFocusNode = new FocusNode();
  String? type;

  Otp({this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(

                colors: [Colors.black.withOpacity(0.9)],
                stops: [0.0]
            ),
            image: DecorationImage(
              image: AssetImage("images/signup_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10),
                  child: new Row(
                    children: [
                      new InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: new Container(
                          width: 30,
                          height: 20,
                          child: Image.asset("images/back_button.png"),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          color: AppTheme().color_white,
                          //fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: 22),
                    )),
                SizedBox(height: 40.0),
                Container(
                  width: 100,
                  height: 100,
                  child: Container(
                      margin: EdgeInsets.all(30.0),
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset(
                        'images/phone.png',
                      )),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 0.3)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'We sent a code',
                      style: TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, right: 10.0, top: 8.0),
                    child: Text(
                      'Enter the 4-digit code sent to your',
                      style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, right: 10.0, top: 0.0),
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat-SemiBold",
                          color: Colors.white),
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0, left: 170.0, right: 170.0),
                  alignment: Alignment.center,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: new EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                //margin: EdgeInsets.fromLTRB(15,0,10,0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 0, left: 0),
                                  child: new Container(
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                          color: AppTheme().color_white,
                                          border: new Border.all(
                                              width: 1.0,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1)),
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(100.0))),
                                      child: new TextFormField(
                                        cursorColor: AppTheme().color_red,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context).requestFocus(
                                              textSecondFocusNode);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        enabled: true,
                                        controller: controller1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: AppTheme().color_red,
                                        fontFamily: "Montserrat-SemiBold"),
                                      )),
                                ),
//                                PinInputTextField(
//                                  pinLength: 4,
//                                  decoration: UnderlineDecoration(
//                                      textStyle: TextStyle(
//                                          color: Colors.black)),
//                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right:0, left: 0),
                                  child: new Container(
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                          color: AppTheme().color_white,
                                          border: new Border.all(
                                              width: 1.0,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1)),
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(100.0))),
                                      child: new TextFormField(
                                        cursorColor: AppTheme().color_red,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        keyboardType: TextInputType.phone,
                                        focusNode: textSecondFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context)
                                              .requestFocus(textThirdFocusNode);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        enabled: true,
                                        controller: controller2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: AppTheme().color_red,
                                            fontFamily: "Montserrat-SemiBold"),
                                      )),
                                ),
//                                PinInputTextField(
//                                  pinLength: 4,
//                                  decoration: UnderlineDecoration(
//                                      textStyle: TextStyle(
//                                          color: Colors.black)),
//                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(10,0,10,0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right:0, left: 0),
                                  child: new Container(
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: AppTheme().color_white,
                                        border: new Border.all(
                                            width: 1.0,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.1)),
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(200.0)),
                                      ),
                                      child: new TextFormField(
                                        cursorColor:AppTheme().color_red,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        keyboardType: TextInputType.phone,
                                        focusNode: textThirdFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              textFourthFocusNode);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        enabled: true,
                                        controller: controller3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: AppTheme().color_red,
                                            fontFamily: "Montserrat-SemiBold"),
                                      )),
                                ),
//                                PinInputTextField(
//                                  pinLength: 4,
//                                  decoration: UnderlineDecoration(
//                                      textStyle: TextStyle(
//                                          color: Colors.black)),
//                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                //  margin: EdgeInsets.fromLTRB(10,0,15,0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 0, left: 0),
                                  child: new Container(
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                          color: AppTheme().color_white,
                                          border: new Border.all(
                                              width: 1.0,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1)),
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(100.0))),
                                      child: new TextFormField(

                                        cursorColor: AppTheme().color_red,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                        keyboardType: TextInputType.phone,
                                        focusNode: textFourthFocusNode,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        enabled: true,
                                        controller: controller4,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: AppTheme().color_red,
                                            fontFamily: "Montserrat-SemiBold"),
                                      )),
                                ),
//                                PinInputTextField(
//                                  pinLength: 4,
//                                  decoration: UnderlineDecoration(
//                                      textStyle: TextStyle(
//                                          color: Colors.black)),
//                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  margin: EdgeInsets.only(left: 30.0, top: 0.0, right: 30.0),
                  child: ButtonTheme(

                    child: ElevatedButton(
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: "Montserrat"),
                        ),
                        onPressed: () {
                          if (controller1.text.length != 0 &&
                              controller2.text.length != 0 &&
                              controller3.text.length != 0 &&
                              controller4.text.length != 0) {
                            sendOtp(controller1.text +
                                controller2.text +
                                controller3.text +
                                controller4.text);
                          } else {
                            Toast.show("" + "Please enter full otp", context,
                                duration: Toast.lengthLong,
                                gravity: Toast.top,);
                          }
                        },
                       ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Resend Code in $_start",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat-SemiBold",
                        color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  Future<Map<String, dynamic>> sendOtp(String otp) async {
    print(otp);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    String myUrl = "$baseUrl/party/User/otpAuth";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "type": type.toString(),
      "otp": controller1.text +
          controller2.text +
          controller3.text +
          controller4.text,
    });
    var parsedJson = json.decode(response.body);

    print("status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
      value = parsedJson['data'];
/*
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
      _timer!.cancel();
      if (type == "forget") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          _onChanged(true, value);
        });
        // Navigator.of(context).pushNamedAndRemoveUntil('/screen2', (Route<dynamic> route) => false);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Number_of_Person()),
                (Route<dynamic> route) => false);
      }

/*  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );*/
    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);
    }
    return parsedJson;
  }

  Future<Map<String, dynamic>> reSendOtp() async {
    sharedPreferences = await SharedPreferences.getInstance();
    num = sharedPreferences.getString("number");
    print(num);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    String myUrl = "$baseUrl/party/User/resendOtp";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'}, body: {"number": num});

    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
      // temp = 1;
      /* Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
      resendotp = parsedJson['message'];
      otp1 = resendotp.split(' ')[3].split('').reversed.join();
    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);
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
      sharedPreferences.commit();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _start--;
        print(_start);
      });
      if (_start == -1) {
        reSendOtp();
        _start = 60;
      }
      if (_start == 50) {
        // receiveMsg();
        //  getOtp();
      }
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
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
  // void receiveMsg() {
  //   SmsReceiver receiver = new SmsReceiver();
  //   receiver.onSmsReceived.listen((SmsMessage msg) {
  //     List<String> data = msg.body.split(': ');
  //     var otpdata = data[1];
  //     List<String> o = otpdata.split('');
  //     print(o);
  //     controller1.text = o[0];
  //     controller2.text = o[1];
  //     controller3.text = o[2];
  //     controller4.text = o[3];
  //   });

  // }
  /*getOtp() async {
    List<SmsMessage> messages =
    await new SmsQuery().querySms(address: '+919871949688');
    print(messages[0].body);
    List<String> data = messages[0].body.split(': ');
//    Toast.show(data[1], context, duration: Toast.lengthShort, gravity:  Toast.bottom,);
    var otpdata = data[1];
    List<String> o = otpdata.split('');
    print(o);
    controller1.text = o[0];
    controller2.text = o[1];
    controller3.text = o[2];
    controller4.text = o[3];
  }*/
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
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
