import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:flutter/services.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../rest_api/ApiList.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  ContactUsPage createState() => ContactUsPage();
}

class ContactUsPage extends State<ContactUs> {
  AnimationController? _controller;
  File? _image;
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutDakibaa()),
      );
    } else {
      pr.close();
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthShort,
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
    // TODO: implement initState
    super.initState();
    getContact();
    /*Random rnd = new Random();
    int sum=0;
    var orderno = rnd.nextInt(10);
    print(orderno);
    sum=orderno+1*6;
    print(sum);*/
  }

  @override
  Widget build(BuildContext context) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return Form(
      key: _formkey,
      child: Container(
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
                                child: Container(
                                  child: Image.asset(
                                    "images/contact_logo.png",
                                    fit: BoxFit.fill,
                                    height: 40,
                                    width: 40,
                                  ),
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
                        GestureDetector(
                          onTap: () {
                            launch("tel://" + number);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme().color_red,
                                  borderRadius: BorderRadius.circular(50)),
                              width: MediaQuery.of(context).size.width / 2.6,
                              height: 45,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/call.png",
                                      height: 20,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Call Us",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontFamily: "Montserrat-SemiBold",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              mesg = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme().color_red,
                                borderRadius: BorderRadius.circular(50)),
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 45,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/mesg.png",
                                    height: 20,
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Message",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme().color_white,
                                      fontFamily: "Montserrat-SemiBold",
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        mesg == false
                            ? Container()
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20, right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme().color_white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter name";
                                            } else if (value
                                                .contains(RegExp(r'[0-9]'))) {
                                              return "Invalid Name";
                                            } else if (value.contains(
                                                    RegExp(r'[#?!@$%^&*-]')) ||
                                                value.contains(
                                                    RegExp(r'[0-9]'))) {
                                              return "Invalid Name";
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppTheme().color_red,
                                              fontFamily:
                                                  "Montserrat-SemiBold"),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Your Name*",
                                            hintStyle: TextStyle(
                                                fontSize: 18.0,
                                                color: AppTheme().color_red,
                                                fontFamily:
                                                    "Montserrat-SemiBold"),
                                            //contentPadding: EdgeInsets.only(top: 0)
                                          ),
                                          controller: nameController,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme().color_white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter email";
                                            } else if (!regex.hasMatch(value)) {
                                              return "Enter Valid Email";
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            FilteringTextInputFormatter(
                                                RegExp("[ ]"),
                                                allow: false)
                                          ],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppTheme().color_red,
                                              fontFamily:
                                                  "Montserrat-SemiBold"),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Your Email*",
                                            hintStyle: TextStyle(
                                                fontSize: 18.0,
                                                color: AppTheme().color_red,
                                                fontFamily:
                                                    "Montserrat-SemiBold"),
                                          ),
                                          controller: emailController,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme().color_white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Contact Number";
                                            } else if (value.length != 10) {
                                              return "contact must be of 10 digits";
                                            } else {
                                              return null;
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppTheme().color_red,
                                              fontFamily:
                                                  "Montserrat-SemiBold"),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Your Contact*",
                                            hintStyle: TextStyle(
                                                fontSize: 18.0,
                                                color: AppTheme().color_red,
                                                fontFamily:
                                                    "Montserrat-SemiBold"),
                                          ),
                                          controller: contactController,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppTheme().color_white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter message";
                                              } else {
                                                return null;
                                              }
                                            },
                                            textAlign: TextAlign.center,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppTheme().color_red,
                                                fontFamily:
                                                    "Montserrat-SemiBold"),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Your Message*",
                                              hintStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: AppTheme().color_red,
                                                  fontFamily:
                                                      "Montserrat-SemiBold"),
                                            ),
                                            controller: messageController,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    height: 45,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          setState(() {});
                                          getData();
                                        }
                                        ;
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: AppTheme().color_red,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.6,
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              "SEND",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme().color_white,
                                                fontFamily:
                                                    "Montserrat-SemiBold",
                                                fontSize: 20,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
