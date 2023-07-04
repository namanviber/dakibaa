import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/ContactUs.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/Privacy.dart';
import 'package:partyapp/Services.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/TermsCon.dart';
import 'package:partyapp/about_dakibaa.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/about_us.dart';
import 'package:partyapp/common/constant.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/dakibaa_services.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/faq_screen.dart';
import 'package:partyapp/app_screens/drawer_navigation_screens/gallery.dart';
import 'package:partyapp/app_screens/authorization_screens/login_pagenew.dart';
import 'package:partyapp/orderhistoy.dart';
import 'package:partyapp/profile_update.dart';
import 'package:partyapp/models/services_model.dart';
import 'package:partyapp/utils/services_presenter.dart';
import 'package:partyapp/widgets/appDrawer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_password.dart';

class Number_of_Person extends StatefulWidget {
  @override
  _Number_of_PersonState createState() => _Number_of_PersonState();
}

class _Number_of_PersonState extends State<Number_of_Person>
    implements ServicesModelContract {
  late ServicesModelPresenter _presenter;
  _Number_of_PersonState() {
    _presenter = new ServicesModelPresenter(this);
  }
  var pr;
  double? screenHeight;
  double? screenwidth;
  bool status = false;
  bool? checkValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? personError;
  TextEditingController personContoller = new TextEditingController();
  var name, email, id, gender, mobile, noperson, phone, dob;

  bool validation() {
    personError = null;
    if (noperson == null || noperson == "") {
      setState(() {
        personError = 'Enter Person';
        status = false;
      });
    } else if (noperson == "0") {
      setState(() {
        personError = 'Enter Number of Person ';
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
    return status;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      noperson = "15";
      person = int.parse(noperson);
      personContoller.text = "15";
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: AppTheme().color_black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new ListView(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.04,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.black.withOpacity(0.3)
                      ], stops: [
                        0.0,
                      ]),
                      image: DecorationImage(
                        image: AssetImage("images/services_background.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      )),
                  child: Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 20),
                          child: new Row(
                            children: [
                              new InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                child: new Container(
                                  child: new Image.asset("images/menu.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 6,
                            ),
                            child: Container(
                                child: Center(
                                    child: Text(
                              "Planning for Party !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme().color_white,
                                  fontSize: 25,
                                  fontFamily: "Montserrat"),
                            ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 90),
                          child: Center(
                              child: Text(
                            "Number of Guests",
                            style: TextStyle(
                                color: AppTheme().color_white,
                                fontSize: 22,
                                fontFamily: "Montserrat-SemiBold"),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: personError == null
                                  ? 0
                                  : MediaQuery.of(context).size.height / 25,
                              left: 60),
                          child: new Container(
                            child: new Row(
                              children: [
                                Text(
                                  personError == null ? "" : personError!,
                                  style: TextStyle(
                                      color: AppTheme().color_white,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 50.0, top: 8, right: 50.0),
                          child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppTheme().color_white,
                                  borderRadius: BorderRadius.circular(50)),
                              //margin: EdgeInsets.only(left: 20.0,top: MediaQuery.of(context).size.height/15,right: 20.0),
                              child: Center(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: AppTheme().color_red,
                                      fontFamily: 'Montserrat-SemiBold',
                                      fontSize: 18),
                                  /* validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter name';
                                               }
                                                return null;
                                             },*/
                                  onChanged: (value) {
                                    setState(() {
                                      noperson = value;
                                      person = int.parse(noperson);
                                      print("Person : " + person.toString());
                                    });
                                  },
                                  cursorColor: AppTheme().color_red,
                                  controller: personContoller,
                                  textAlign: TextAlign.center,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    hintStyle: new TextStyle(
                                        color: AppTheme().color_red,
                                        fontFamily: 'Montserrat-SemiBold',
                                        fontSize: 18),
                                    hintText: "Enter Person",
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, right: 110, left: 110),
                          child: GestureDetector(
                            onTap: () {
                              if (validation()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Services()));
                              }
                            },
                            child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: AppTheme().color_red,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: AppTheme().color_red)),
                                child: Center(
                                  child: Text(
                                    "Continue".toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        color: AppTheme().color_white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onServicesModelError(String errorTxt) {
    // TODO: implement onServicesModelError
    pr.hide();
    print("services error :  " + errorTxt);
  }

  @override
  void onServicesModelSuccess(ServicesModel response) {
    // TODO: implement onServicesModelSuccess
    if (response != null) {
      pr.hide();
      setState(() {
        SERVICESRESPONSE = response;
        SERVICES_LIST = SERVICESRESPONSE.servicesModel_list;
        //SERVICES_LIST.removeAt(2);
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Services()),
      );
    }
  }
}
