import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/shared_preferences.dart';
import 'package:dakibaa/network/network.dart';
import 'package:dakibaa/app_screens/home_screens/guestCount.dart';
import 'package:dakibaa/app_screens/authorization_screens/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';
import '../../common/constant.dart';
import '../../widgets/appBody.dart';
import '../../widgets/appButton.dart';
import '../../widgets/appTextField.dart';
import 'forgetPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? usernameError, passwordError;
  String? password, email;
  bool checkValue = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  late SharedPreferences sharedPreferences;
  final _formkey = GlobalKey<FormState>();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      body: AppBody(
        imgPath: "images/background.jpg",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                // Dakibaa Logo
                Image.asset(
                  'images/dakiba_logo.png',
                  width: 300,
                  fit: BoxFit.cover,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        AppTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains("@") ||
                                  !value.contains('.')) {
                                return 'Email address is not Valid.';
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            hinttext: "Email ID"),
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
                          hinttext: "Password",
                          ispass: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPass()),
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
                          color: AppTheme().colorWhite),
                    ),
                  ),
                ),
                AppButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      // getData();
                      signIn(emailController.text.toLowerCase().trim(),
                          passwordController.text.trim());
                    } else {
                      Toast.show(
                        "Please Enter Your Credentials",
                        duration: Toast.lengthLong,
                        gravity: Toast.bottom,
                      );
                    }
                  },
                  title: "Sign In",
                ),
                AppButton(
                  onPressed: () {
                    setGuest();
                    pr = ProgressDialog(
                      context: context,
                    );
                    pr.show(msg: "Singing in...");
                    NetworkConnection.check().then((intenet) async {
                      print(intenet);
                      if (intenet != null && intenet) {
                        pr.close();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Number_of_Person()));
                      } else {
                        pr.close();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InternetConnection()));
                      }
                    });
                  },
                  title: "Guest Sign In",
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
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

  // Functions

  signIn(String email, String password) async {
    ToastContext().init(context); //-> This part
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Processing..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.usersLogin),
          headers: {'Accept': 'application/json'},
          body: {"email": email, "password": password});

      print("Data:  ${Uri.parse(APIS.usersLogin)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          SharedPreferencesClass().setloginstatus(true);
          sharedPreferences = await SharedPreferences.getInstance();
          setState(() {
            var value = parsedJson["data"][0];
            _onChanged(true, value);
            sharedPreferences.setBool("isguest", false);
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Number_of_Person()),
              (Route<dynamic> route) => false);
        } else {
          pr.close();
          ToastContext().init(context); //-> This part
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

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response!["Name"]);
      sharedPreferences.setString("id", response["id"].toString());
      sharedPreferences.setString("mobile", response["Mobile"]);
      sharedPreferences.setString("password", response["Password"]);
      sharedPreferences.setString("profile_pic", response["ProfilePic"]);
      profile_pic = response["ProfilePic"];
    });
  }

  setGuest() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
      sharedPreferences.setBool("check", true);
      sharedPreferences.setBool("isguest", true);
      sharedPreferences.setString("id", "");
      loginstatus = "guest";
    });
  }

  bool SignupValidation() {
    setState(() {
      status = true;
    });

    passwordError = null;
    usernameError = null;
    if (email == "" || email == null) {
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
}
