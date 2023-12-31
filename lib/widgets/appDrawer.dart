import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/ContactUs.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/Privacy.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/TermsCon.dart';
import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/aboutUs.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/changePassword.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/servicesOffered.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/faq_screen.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/orderhistoy.dart';
import 'package:dakibaa/app_screens/drawer_navigation_screens/updateProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/constant.dart';
import '../app_screens/drawer_navigation_screens/gallery.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool checkValue = false;
  bool isguest = false;
  var name, email, id, gender, mobile, noperson, phone, dob;

  TextStyle listText = TextStyle(
      color: AppTheme().colorWhite,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: "MontBlancDemo-Bold-Medium");

  getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check") ?? false;

      if (checkValue == null || checkValue == false) {
        sharedPreferences.clear();
        sharedPreferences.setBool("check", false);
        checkValue = false;
      } else {
        isguest = sharedPreferences.getBool("isguest") ?? false;
        name = sharedPreferences.getString("name");
        id = sharedPreferences.getString("id");
        gender = sharedPreferences.getString("gender");
        mobile = sharedPreferences.getString("mobile");
        dob = sharedPreferences.getString("dob");
        email = sharedPreferences.getString("email");
        profile_pic = sharedPreferences.getString("profile_pic");
      }
    });
  }

  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme().colorRed,
      child: ListView(
        children: [
          SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: (checkValue)
                    ? Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().colorWhite,
                                        border: Border.all(
                                            color: AppTheme().colorWhite,
                                            width: 5)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        child: profile_pic == null
                                            ? Image.asset(
                                                "images/categorys_image.jpg",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "http://192.168.1.6:3500/resources/${profile_pic!}",
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    "images/categorys_image.jpg",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ))),
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
                                          ? MediaQuery.of(context).size.height /
                                              10.5
                                          : MediaQuery.of(context).size.height /
                                              13),
                                  child: Center(
                                    child: Text(
                                      name ?? "Guest Login",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppTheme().colorWhite,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Text(
                                      email ?? "",
                                      style: TextStyle(
                                          color: AppTheme().colorWhite,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Image.asset(
                              "images/dakiba_logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 2,
              color: Colors.red[400],
            ),
          ),
          ListTile(
            title: Text("Home", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/home.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutDakibaa()));
            },
          ),
          (checkValue && !isguest)
              ? ListTile(
                  title: Text("Profile", style: listText),
                  leading: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.person,
                        color: AppTheme().colorWhite,
                        size: 30,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileUpdate()));
                  },
                )
              : const SizedBox(),
          (checkValue && !isguest)
              ? ListTile(
                  title: Text("Change Password", style: listText),
                  leading: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/change_password.png",
                        width: 30,
                        height: 30,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePassword()));
                  },
                )
              : const SizedBox(),
          ListTile(
            title: Text("Privacy", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/privacy.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Privacy()));
            },
          ),
          ListTile(
            title: Text("FAQs", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/faqs.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()));
            },
          ),
          ListTile(
            title: Text("T&C", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/tc.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsCondition()));
            },
          ),
          ListTile(
            title: Text("Gallery", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/gallery.png",
                  width: 30,
                  height: 30,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Gallery()));
            },
          ),
          (checkValue && !isguest)
              ? ListTile(
                  title: Text("Order History",
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/order_hist.ico",
                        width: 30,
                        height: 30,
                        color: AppTheme().colorWhite,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderHistoryScreen()));
                  },
                )
              : const SizedBox(),
          ListTile(
            title: Text("Services", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/services.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().colorWhite,
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DakibaaServices()));
            },
          ),
          ListTile(
            title: Text("Contact Us", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/contact_us.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactUs()));
            },
          ),
          ListTile(
            title: Text("About Us", style: listText),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/aboutus.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().colorWhite,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          (checkValue)
              ? ListTile(
                  title: Text("Logout",
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/logout.png",
                        width: 30,
                        height: 30,
                      )),
                  onTap: () {
                    dialogs("Confirm Logout");
                  },
                )
              : const SizedBox(),
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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3,
              bottom: MediaQuery.of(context).size.height / 3),
          child: AlertDialog(
            backgroundColor: AppTheme().colorRed,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(top: 0),
                        width: 200,
                        child: Center(
                          child: Text(
                            mesg,
                            style: TextStyle(
                                color: AppTheme().colorWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ))
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppTheme().colorWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text("Cancel",
                              style: TextStyle(
                                  color: AppTheme().colorRed,
                                  fontSize: 15,
                                  fontFamily: "Montserrat-SemiBold")),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    InkWell(
                      onTap: () {
                        logOut();
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppTheme().colorWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: AppTheme().colorRed,
                                fontSize: 15,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
        );
      },
    );
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
      sharedPreferences.setBool("check", false);
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AboutDakibaa()),
        (Route<dynamic> route) => false);
  }
}
