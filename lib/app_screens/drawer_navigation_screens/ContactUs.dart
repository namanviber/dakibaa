import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../rest_api/ApiList.dart';
import '../../widgets/appButton.dart';
import '../../widgets/appTextField.dart';

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
              children: [
                Center(
                  child: Container(
                      padding: const EdgeInsets.only(
                        left: 0.0,
                        right: 0.0,
                        top: 100.0,
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
                          AppTextField(validator: (value) {
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
                          }, controller: nameController, hinttext: "Name",),
                          AppTextField(validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your contact';
                            } else if (value.length != 10) {
                              return "contact must be of 10 digits";
                            } else {
                              return null;
                            }
                          }, controller: contactController, hinttext: "Contact No.", isphone: true),
                          AppTextField(validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains("@") ||
                                !value.contains('.')) {
                              return 'Email address is not Valid.';
                            } else {
                              return null;
                            }
                          }, controller: emailController, hinttext: "Email",),
                          AppTextField(validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Message';
                            }
                            return null;
                          }, controller: messageController, hinttext: "Message",),
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
            ),
          ),
        ),
      ),
    );
  }
}
