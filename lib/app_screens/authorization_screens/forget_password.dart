import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../rest_api/ApiList.dart';
import 'forget_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

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
  final user_NameController = TextEditingController();
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
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
            ),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        //_scaffoldKey.currentState.openDrawer();
                      },
                      child: SizedBox(
                        height: 18,
                        child: Image.asset(
                          "images/back_button.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    alignment: Alignment.center,
                    //padding: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: AppTheme().color_white,
                          // fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: 22),
                    )),
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
                margin:
                    const EdgeInsets.only(top: 15.0, left: 170.0, right: 170.0),
                alignment: Alignment.center,
                child: const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.white,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                child: TextFormField(
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your contact';
                    } else if (value.length != 10) {
                      return "contact must be of 10 digits";
                    } else {
                      return null;
                    }
                  },
                  textAlign: TextAlign.center,
                  controller: user_NameController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      errorStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat-SemiBold",
                          color: AppTheme().color_white),
                      hintStyle: TextStyle(
                          color: AppTheme().color_red,
                          fontFamily: "Montserrat-SemiBold"),
                      hintText: "Contact No.",
                      counterText: "",
                      fillColor: AppTheme().color_white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppTheme().color_red)),
                  child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        setState(() {});

                        _onChanged(user_NameController.text);
                        getCheckData();
                      } else {}
                      /*    if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              setState(() {});
                              UsernameController.text;
                              UserPasswordController.text;
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home+

                                Page()),
                              );
                            }*/
                    },
                    child: Center(
                      child: Text(
                        "Submit".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                            color: AppTheme().color_white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onChanged(String contact) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("number", contact);
    });
  }

  Future<Map<String, dynamic>> getCheckData() async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Loading..", barrierDismissible: true);
    // print(token);
    final response = await http.post(Uri.parse(APIS.checkRegistration),
        headers: {'Accept': 'application/json'},
        body: {"value": user_NameController.text});
    var parsedJson = json.decode(response.body);
    value = parsedJson['result'];
    if (parsedJson['status'] == "1") {
      pr.close();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  ForgetForm(number: user_NameController.text)),
          (Route<dynamic> route) => false);
    } else if (parsedJson['status'] == "0") {
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
