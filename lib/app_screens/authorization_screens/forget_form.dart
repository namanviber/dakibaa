import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import '../../rest_api/ApiList.dart';
import 'otp_screen.dart';

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
  bool passwordVisible = true;
  bool passwordVisible1 = true;
  final _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.8),
            ],
          ),
          image: DecorationImage(
            image: const AssetImage("images/services_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          )),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                        color: AppTheme().colorWhite,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: 22),
                  )),
              const SizedBox(height: 40.0),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
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
                height: 10.0,
              ),
              Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 30.0, right: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      obscureText: passwordVisible,
                      controller: new_PasswordController,
                      style: TextStyle(
                          color: AppTheme().colorRed,
                          fontFamily: "Montserrat-SemiBold"),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.red,
                              )),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().colorRed,
                              fontFamily: "Montserrat-SemiBold"),
                          hintText: "New Password",
                          fillColor: AppTheme().colorWhite),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 25.0, right: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != new_PasswordController.text) {
                          return 'Password is not matching';
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: AppTheme().colorRed,
                          fontFamily: "Montserrat-SemiBold"),
                      textAlign: TextAlign.center,
                      obscureText: passwordVisible1,
                      decoration: InputDecoration(
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
                                color: Colors.red,
                              )),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().colorRed,
                              fontFamily: "Montserrat-SemiBold"),
                          hintText: "Confirm New Password",
                          fillColor: AppTheme().colorWhite),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 90.0, top: 25.0, right: 90.0),
                child: SizedBox(
                  height: 45,

                  //margin: EdgeInsets.only(left: 20.0,top: 25.0,right: 20.0),
                  child: ElevatedButton(
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        getData();
                      }

//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => ChangePassword()),
//                            );
                    },
                  ),
                ),
              ),
            ],
          )),
    ));
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible1 = true;
  }

  Future<Map<String, dynamic>> getData() async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Loading..", barrierDismissible: true);
    // print(token);
    final response = await http.post(Uri.parse(APIS.forgetPassword), headers: {
      'Accept': 'application/json'
    }, body: {
      "number": number.toString(),
      "password": new_PasswordController.text
    });
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    if (parsedJson['status'] == "1") {
      pr.close();
      /*   Toast.show(parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
      //_onChanged(value);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  type: 'forget',
                  mobile: widget.number,
                )),
      );
    } else {
      pr.close();
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    }
    return parsedJson;
  }
}
