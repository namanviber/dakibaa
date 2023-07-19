import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/Colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../rest_api/ApiList.dart';
import '../../widgets/appButton.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  ContactUsPage createState() => ContactUsPage();
}

class ContactUsPage extends State<ContactUs> {
  bool status = false;
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  Map<String, dynamic>? value1;
  List<dynamic>? listData;
  bool mesg = false;
  Map? data;
  var name;
  var mail;
  var address;
  late var number;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void sendMessage() async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Sending Message..", barrierDismissible: true);

    try {
      final response = await http.post(Uri.parse(APIS.addMessage), headers: {
        'Accept': 'application/json'
      }, body: {
        "name": nameController.text,
        "email": emailController.text,
        "message": messageController.text,
        "mobile": contactController.text
      });

      print("Data:  ${Uri.parse(APIS.addMessage)}");

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");

        if (parsedJson['status'] == "1") {
          pr.close();
          Toast.show(
            parsedJson['message'],
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
          Navigator.pop(context);
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

  Future<Map<String, dynamic>> getData() async {
    ToastContext().init(context); //-> This part

    //  print(myController1.text);
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Loading..", barrierDismissible: true);
    // print(token);
    final response = await http.post(Uri.parse(APIS.addMessage), headers: {
      'Accept': 'application/json'
    }, body: {
      "name": nameController.text,
      "email": emailController.text,
      "message": messageController.text,
      "mobile": contactController.text
    });
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];

    if (parsedJson['status'] == "1") {
      pr.close();
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
      //_onChanged(value);
      Navigator.pop(context);
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

  Future getContact() async {
    // _isProgressBarShown = true;
    http.Response response = await http.get(Uri.parse(APIS.ownerDetail));
    var datatc = json.decode(response.body);
    setState(() {
      name = datatc['data']['Name'] ?? '';
      mail = datatc['data']['Email'] ?? '';
      address = datatc['data']['Address'] ?? '';
      number = datatc['data']['Mobile'] ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); //-> This part
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 1,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 18,
                  child: Image.asset(
                    "images/back_button.png",
                  ),
                ),
              );
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                            padding: const EdgeInsets.only(
                              left: 0.0,
                              right: 0.0,
                              top: 10.0,
                            ),
                            child: Center(
                              child: Image.asset(
                                "images/contact_logo.png",
                                fit: BoxFit.fill,
                                height: 40,
                                width: 40,
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: const Center(
                          child: Text(
                            "Contact us",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: "Montserrat"
                                //fontWeight: FontWeight.w600,
                                //letterSpacing: 1
                                ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 20, 0, 5),
                        width: MediaQuery.of(context).size.width - 32,
                        child: const Center(
                          child: Text(
                            "Feel Free To Drop Us a Message Or Call",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                          onPressed: () {
                            launchUrl(Uri.parse("tel:// $number"));
                          },
                          title: "Call Us",
                        icon: Icons.call,
                      ),
                      AppButton(
                          onPressed: () {
                            setState(() {
                              mesg = true;
                            });
                          },
                          title: "Message",
                        icon: Icons.message,
                      ),

                      mesg == false
                          ? Container()
                          : Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, top: 15.0, right: 50.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Name';
                                      } else if (value.length < 4 &&
                                          value.length > 20) {
                                        return 'Enter atLeast 4 digit.';
                                      } else if (!value
                                          .contains(RegExp(r'[a-zA-Z]'))) {
                                        return 'Invalid Name.';
                                      } else if (value
                                          .contains(RegExp(r'[0-9]'))) {
                                        return 'Invalid Name.';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppTheme().colorWhite),
                                          borderRadius:
                                              const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        focusedBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        errorStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat-SemiBold",
                                            color: AppTheme().colorWhite),
                                        hintStyle: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                "Montserrat-SemiBold"),
                                        hintText: "Name",
                                        fillColor: AppTheme().colorWhite),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, top: 15.0, right: 50.0),
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
                                    controller: contactController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        focusedBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        errorStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat-SemiBold",
                                            color: AppTheme().colorWhite),
                                        hintStyle: TextStyle(
                                            color: AppTheme().colorRed,
                                            fontFamily:
                                                "Montserrat-SemiBold"),
                                        hintText: "Contact No.",
                                        counterText: "",
                                        fillColor: AppTheme().colorWhite),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, top: 15.0, right: 50.0),
                                  child: TextFormField(
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
                                    textAlign: TextAlign.center,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                        focusedBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        errorStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat-SemiBold",
                                            color: AppTheme().colorWhite),
                                        hintStyle: TextStyle(
                                            color: AppTheme().colorRed,
                                            fontFamily:
                                                "Montserrat-SemiBold"),
                                        hintText: "Email ID",
                                        counterText: "",
                                        fillColor: AppTheme().colorWhite),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0,
                                      top: 15.0,
                                      right: 50.0,
                                      bottom: 15),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Message';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: AppTheme().colorWhite),
                                          borderRadius:
                                              const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        focusedBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        enabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        errorStyle: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Montserrat-SemiBold",
                                            color: AppTheme().colorWhite),
                                        hintStyle: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                "Montserrat-SemiBold"),
                                        hintText: "Message",
                                        fillColor: AppTheme().colorWhite),
                                  ),
                                ),
                                AppButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();
                                        setState(() {});
                                        sendMessage();
                                        // getData();
                                      }
                                    },
                                    title: "Send"
                                ),
                              ],
                            )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
