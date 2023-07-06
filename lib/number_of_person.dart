import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/Services.dart';
import 'package:dakibaa/common/constant.dart';
import 'package:dakibaa/models/services_model.dart';
import 'package:dakibaa/utils/services_presenter.dart';
import 'package:dakibaa/widgets/appDrawer.dart';

class Number_of_Person extends StatefulWidget {
  @override
  _Number_of_PersonState createState() => _Number_of_PersonState();
}

class _Number_of_PersonState extends State<Number_of_Person>
    implements ServicesModelContract {
  late ServicesModelPresenter _presenter;
  _Number_of_PersonState() {
    _presenter = ServicesModelPresenter(this);
  }
  var pr;
  double? screenHeight;
  double? screenwidth;
  bool status = false;
  bool? checkValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? personError;
  TextEditingController personContoller = TextEditingController();
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
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
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
                        image: const AssetImage("images/services_background.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      )),
                  child: Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                child: Container(
                                  child: Image.asset("images/menu.png"),
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
                          padding: const EdgeInsets.only(top: 90),
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
                          child: Container(
                            child: Row(
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
                              const EdgeInsets.only(left: 50.0, top: 8, right: 50.0),
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
                                      const TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    hintStyle: TextStyle(
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
    pr.close();
    
  }

  @override
  void onServicesModelSuccess(ServicesModel response) {
    // TODO: implement onServicesModelSuccess
    if (response != null) {
      pr.close();
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
