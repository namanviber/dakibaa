import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/shared_preferences.dart';
import 'package:dakibaa/network/network.dart';
import 'package:dakibaa/app_screens/home_screens/number_of_person.dart';
import 'package:dakibaa/app_screens/authorization_screens/signup_pagenew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import '../../rest_api/ApiList.dart';
import '../../common/constant.dart';
import 'forget_password.dart';
import '../../home_page.dart';

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
  bool passwordVisible1 = true;
  final _formkey = GlobalKey<FormState>();
  bool status = false;
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

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); //-> This part
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme().color_black,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Colors.white.withOpacity(0.1),
                Colors.black,
                Colors.black,
              ], stops: const [
                0.0,
                1,
                1
              ]),
              image: DecorationImage(
                image: const AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, top: 50.0, right: 20.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
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
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppTheme().color_white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                errorStyle: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat-SemiBold",
                                    color: AppTheme().color_white),
                                hintStyle: TextStyle(
                                    color: Colors.red[800],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat-SemiBold"),
                                hintText: "Email",
                                fillColor: AppTheme().color_white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, top: 15.0, right: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 8) {
                                return "Password must be of min 8 digits and max 15 digits";
                              } else if (value.length > 16) {
                                return "Password must be of min 8 digits and max 15 digits";
                              } else if (!value.contains(RegExp(r'[A-Z]'))) {
                                return "Password should contain upper,lower,digit and Special character";
                              } else if (!value.contains(RegExp(r'[0-9]'))) {
                                return "Password should contain upper,lower,digit and Special character";
                              } else if (!value.contains(RegExp(r'[a-z]'))) {
                                return "Password should contain upper,lower,digit and Special character";
                              } else if (!value
                                  .contains(RegExp(r'[#?!@$%^&*-]'))) {
                                return "Password should contain upper,lower,digit and Special character";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            controller: passwordController,
                            obscureText: passwordVisible1,
                            keyboardType: TextInputType.text,
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                errorStyle: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Montserrat-SemiBold",
                                    color: AppTheme().color_white),
                                hintStyle: TextStyle(
                                    color: AppTheme().color_red,
                                    fontFamily: "Montserrat-SemiBold"),
                                hintText: "Password",
                                counterText: "",
                                fillColor: AppTheme().color_white),
                          ),
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
                      MaterialPageRoute(builder: (context) => ForgotPass()),
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
                          color: AppTheme().color_white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppTheme().color_red)),
                  child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        // getData();
                        signIn(emailController.text.toLowerCase().trim(),
                            passwordController.text.trim());
                      } else {
                        Toast.show(
                          "Please Enter Your Credentials",
                          duration: Toast.lengthLong,
                          gravity: Toast.top,
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        "Sign In".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: AppTheme().color_white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenwidth * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppTheme().color_red)),
                  child: GestureDetector(
                    onTap: () {
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
                              builder: (context) => Number_of_Person()));
                        } else {
                          pr.close();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InternetConnection()));
                        }
                      });
                    },
                    child: Center(
                      child: Text(
                        "Guest Sign In".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: AppTheme().color_white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
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

  var returnData;

  void signIn(String email, String password) async {
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
            _onChanged(true, parsedJson['data']);
            sharedPreferences.setBool("isguest", false);
          });
          Toast.show(
            parsedJson['message'],
            duration: Toast.lengthShort,
            gravity: Toast.bottom,
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Number_of_Person()),
              (Route<dynamic> route) => false);
        } else {
          pr.close();
          Toast.show(
            parsedJson['message'],
            duration: Toast.lengthLong,
            gravity: Toast.top,
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

  Future<Map<String, dynamic>> getData() async {
    ToastContext().init(context); //-> This part

    pr = ProgressDialog(
      context: context,
    );
    if (SignupValidation()) {
      NetworkConnection.check().then((intenet) async {
        if (intenet != null && intenet) {
          pr.show(msg: "Loading..", barrierDismissible: true);
          final response = await http.post(Uri.parse(APIS.usersLogin),
              headers: {
                'Accept': 'application/json'
              },
              body: {
                "email": emailController.text,
                "password": passwordController.text
              });
          print(response.body);
          var parsedJson = json.decode(response.body);
          value = parsedJson['data'];

          if (parsedJson['status'] == "1") {
            pr.close();
            SharedPreferencesClass().setloginstatus(true);
            sharedPreferences = await SharedPreferences.getInstance();
            if (mounted) {
              setState(() {
                _onChanged(true, value);
                // sharedPreferences.setString("email", value!["Mobile"]);
                sharedPreferences.setBool("isguest", false);
              });
            }
            Toast.show(
              parsedJson['message'],
              duration: Toast.lengthShort,
              gravity: Toast.top,
            );
            //_onChanged(value);
            loginstatus = "signin";
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Number_of_Person()),
                (Route<dynamic> route) => false);
          } else {
            pr.close();
            Toast.show(
              parsedJson['message'],
              duration: Toast.lengthShort,
              gravity: Toast.bottom,
            );
          }
          return parsedJson;
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InternetConnection()));
        }
      });
    }
    return returnData;
  }

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response!["Name"]);
      sharedPreferences.setString("id", response["id"].toString());
      /* sharedPreferences.setString("gender", response["Gender"]);
      sharedPreferences.setString("dob", response["DOB"]);*/
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

  @override
  void initState() {
    passwordVisible1 = true;
    //getstatus();
  }

  void getstatus() async {
    bool loginstatus = await SharedPreferencesClass().getloginstatus();
    loginstatus == true
        ? Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()))
        : Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
  }
}
