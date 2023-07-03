import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/ContactUs.dart';
import 'package:partyapp/Privacy.dart';
import 'package:partyapp/Services.dart';
import 'package:partyapp/TermsCon.dart';
import 'package:partyapp/about_dakibaa.dart';
import 'package:partyapp/about_us.dart';
import 'package:partyapp/common/constant.dart';
import 'package:partyapp/dakibaa_services.dart';
import 'package:partyapp/faq_screen.dart';
import 'package:partyapp/gallery.dart';
import 'package:partyapp/login_pagenew.dart';
import 'package:partyapp/orderhistoy.dart';
import 'package:partyapp/profile_update.dart';
import 'package:partyapp/services_model/services_model.dart';
import 'package:partyapp/services_presenter.dart';
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
  Widget drawar() {
    return Container(
      color: AppTheme().color_red,
      width: MediaQuery.of(context).size.width / 1.3,
      child: new ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Container(
                height: 150,
                //color: AppTheme().color_gray_light,
                child: new Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: new Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppTheme().color_white,
                                  border: Border.all(
                                      color: AppTheme().color_white, width: 5)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: profile_pic == null
                                      ? Image.asset(
                                          "images/categorys_image.jpg",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "http://partyapp.v2infotech.net/resources/" +
                                              profile_pic!,
                                          fit: BoxFit.cover))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: name == null
                                    ? MediaQuery.of(context).size.height / 10.5
                                    : MediaQuery.of(context).size.height / 13),
                            child: new Container(
                              child: Center(
                                child: new Container(
                                  child: new Text(
                                    name == null ? "Guest Login" : name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: new Container(
                              child: Center(
                                child: new Container(
                                  child: new Text(
                                    email == null ? "" : email,
                                    style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 2,
              color: Colors.red[400],
            ),
          ),
          ListTile(
            title: Text("Home",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/home.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              //getData();
              //Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(milliseconds:0), child: PaymentScreen()));
            },
          ),
          loginstatus == "guest"
              ? Container()
              : ListTile(
                  title: Text("Profile",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.person,
                        color: AppTheme().color_white,
                        size: 30,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.custom,
                            duration: Duration(milliseconds: 0),
                            child: ProfileUpdate()));
                  },
                ),
          loginstatus == "guest"
              ? Container()
              : ListTile(
                  title: Text("Change Password",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/change_password.png",
                        width: 30,
                        height: 30,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.custom,
                            duration: Duration(milliseconds: 0),
                            child: ChangePassword()));
                  },
                ),
          ListTile(
            title: Text("Privacy",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/privacy.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: Privacy()));
            },
          ),
          ListTile(
            title: Text("FAQs",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/faqs.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: FaqScreen()));
            },
          ),
          ListTile(
            title: Text("T&C",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/tc.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: TermsCondition()));
            },
          ),
          loginstatus == "guest"
              ? Container()
              : ListTile(
                  title: Text("Order History",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/order_hist.ico",
                        width: 30,
                        height: 30,
                        color: AppTheme().color_white,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.custom,
                            duration: Duration(milliseconds: 0),
                            child: OrderHistoryScreen()));
                  },
                ),
          ListTile(
            title: Text("Gallery",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/gallery.png",
                  width: 30,
                  height: 30,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: Gallery()));
              //getData();
              //Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(milliseconds:0), child: PaymentScreen()));
            },
          ),
          ListTile(
            title: Text("Services",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/services.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().color_white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: DakibaaServices()));
            },
          ),
          ListTile(
            title: Text("Contact Us",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/contact_us.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: ContactUs()));
            },
          ),
          ListTile(
            title: Text("About Us",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/aboutus.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().color_white,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: AboutUs()));
            },
          ),
          ListTile(
            title: Text("Logout",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/logout.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              dialogs("Confirm Exit");
              //Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(milliseconds:0), child: PaymentScreen()));
            },
          ),
        ],
      ),
    );
  }

  void dialogs(String mesg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3,
              bottom: MediaQuery.of(context).size.height / 3),
          child: AlertDialog(
            backgroundColor: AppTheme().color_red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: new Container(
                child: new Center(
                    child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                        padding: EdgeInsets.only(top: 0),
                        width: 200,
                        child: new Center(
                          child: new Text(
                            mesg,
                            style: new TextStyle(
                                color: new AppTheme().color_white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ))
                  ],
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: new Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppTheme().color_white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text("Cancel",
                              style: TextStyle(
                                  color: AppTheme().color_red,
                                  fontSize: 15,
                                  fontFamily: "Montserrat-SemiBold")),
                        ),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(left: 10)),
                    new InkWell(
                      onTap: () {
                        logOut();
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.custom,
                                duration: Duration(seconds: 0),
                                child: LoginPage()));
                      },
                      child: new Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppTheme().color_white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: AppTheme().color_red,
                                fontSize: 15,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ))),
          ),
        );
      },
    );
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
    });
    //Navigator.of(context).pop();
    //Navigator.popUntil(context, ModalRoute.withName('/'));
    //Navigator.pop(context,true);// It worked for me instead of above line
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstScreen()),);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AboutDakibaa()),
        (Route<dynamic> route) => false);
  }

  bool validation() {
    // setState(() {
    //   status = true;
    // });
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

  void submit() {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    if (validation()) {
      pr.show();
      _presenter.getServices();
    } else {
      print("validationError");
    }
  }

  getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("checkingCheck:  ${sharedPreferences.containsKey("check")}");
    // setState(() {
    //   checkValue = sharedPreferences.getBool("check");
    //   print("CheckVariable: $checkValue");
    //
    //   // ======================== Changed 3 July, 2023 (Naman Jain) ================
    //   if (checkValue == null || checkValue == false){
    //     sharedPreferences.clear();
    //     sharedPreferences.setBool("check", false);
    //     checkValue = false;
    //   } else {
    //     name = sharedPreferences.getString("name");
    //     id = sharedPreferences.getString("id");
    //     gender = sharedPreferences.getString("gender");
    //     mobile = sharedPreferences.getString("mobile");
    //     dob = sharedPreferences.getString("dob");
    //     email = sharedPreferences.getString("email");
    //     profile_pic = sharedPreferences.getString("profile_pic");
    //   }
    // });
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          name = sharedPreferences.getString("name");
          print("$name");
          id = sharedPreferences.getString("id");
          gender = sharedPreferences.getString("gender");
          mobile = sharedPreferences.getString("mobile");
          dob = sharedPreferences.getString("dob");
          email = sharedPreferences.getString("email");
          profile_pic = sharedPreferences.getString("profile_pic");
        } else {
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter.getServices();
    getCredential();
    setState(() {
      noperson = "15";
      person = int.parse(noperson);
      personContoller.text = "15";
    });
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawar(),
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
                              submit();
                            },
                            child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: AppTheme().color_red,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: AppTheme().color_red)),
                                //margin: EdgeInsets.only(top: 5.0,left: 80,right: 80),
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

      if (name == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Services()),
        );
      }
    }
  }
}
