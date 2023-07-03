import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/ContactUs.dart';
import 'package:partyapp/Privacy.dart';
import 'package:partyapp/TermsCon.dart';
import 'package:partyapp/about_dakibaa.dart';
import 'package:partyapp/about_us.dart';
import 'package:partyapp/change_password.dart';
import 'package:partyapp/dakibaa_services.dart';
import 'package:partyapp/faq_screen.dart';
import 'package:partyapp/orderhistoy.dart';
import 'package:partyapp/profile_update.dart';

import '../common/constant.dart';
import '../gallery.dart';

class AppDrawer extends StatefulWidget {
  bool isLogin;
  AppDrawer({this.isLogin = false, super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextStyle listText = TextStyle(
      color: AppTheme().color_white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: "MontBlancDemo-Bold-Medium");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme().color_red,
      child: ListView(
        children: [
          Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: (widget.isLogin)
                    ? Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: new Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().color_white,
                                        border: Border.all(
                                            color: AppTheme().color_white,
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
                                      top: "name" == null
                                          ? MediaQuery.of(context).size.height /
                                              10.5
                                          : MediaQuery.of(context).size.height /
                                              13),
                                  child: new Container(
                                    child: Center(
                                      child: new Container(
                                        child: new Text(
                                          "name" == null
                                              ? "Guest Login"
                                              : "name",
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
                                          "email" == null ? "" : "email",
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
                      )
                    : Center(
                        child: Container(
                            height: 100,
                            child: Center(
                              child: Image.asset(
                                "images/dakiba_logo.png",
                                fit: BoxFit.cover,
                              ),
                            ) /* ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: profile_pic==null?
                            Image.asset("images/categorys_image.jpg",fit: BoxFit.cover,)
                                :Image.network("http://partyapp.v2infotech.net/resources/"+profile_pic,fit: BoxFit.cover)
                        )*/
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
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/home.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AboutDakibaa()));
            },
          ),
          (widget.isLogin)
              ? ListTile(
                  title: Text("Profile", style: listText),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.person,
                        color: AppTheme().color_white,
                        size: 30,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileUpdate()));
                  },
                )
              : SizedBox(),
          (widget.isLogin)
              ? ListTile(
                  title: Text("Change Password", style: listText),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/change_password.png",
                        width: 30,
                        height: 30,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                )
              : SizedBox(),
          ListTile(
            title: Text("Privacy", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/privacy.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Privacy()));
            },
          ),
          ListTile(
            title: Text("FAQs", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/faqs.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FaqScreen()));
            },
          ),
          ListTile(
            title: Text("T&C", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/tc.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TermsCondition()));
            },
          ),
          ListTile(
            title: Text("Gallery", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/gallery.png",
                  width: 30,
                  height: 30,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Gallery()));
            },
          ),
          (widget.isLogin)
              ? ListTile(
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistoryScreen()));
                  },
                )
              : SizedBox(),
          ListTile(
            title: Text("Services", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/services.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().color_white,
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DakibaaServices()));
            },
          ),
          ListTile(
            title: Text("Contact Us", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/contact_us.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ContactUs()));
            },
          ),
          ListTile(
            title: Text("About Us", style: listText),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/aboutus.png",
                  width: 30,
                  height: 30,
                  color: AppTheme().color_white,
                )),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
          ),
          (widget.isLogin)
              ? ListTile(
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
                    // dialogs("Confirm Exit");
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
