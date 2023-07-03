import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:partyapp/profile_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactUs.dart';
import 'Privacy.dart';
import 'TermsCon.dart';
import 'about_us.dart';
import 'change_password.dart';
import 'common/constant.dart';
import 'dakibaa_services.dart';
import 'faq_screen.dart';
import 'gallery.dart';

class AboutDakibaa extends StatefulWidget {
  @override
  _AboutDakibaaState createState() => _AboutDakibaaState();
}

class _AboutDakibaaState extends State<AboutDakibaa> {
  var name, email, id, gender, mobile, noperson, phone, dob;
  bool? checkValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCredential();
  }

  getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: new Container(
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
          ListTile(
            title: Text("Privacy",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
          ListTile(
            title: Text("Gallery",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
                    fontFamily: "MontBlancDemo-Bold-Medium")),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: Image.asset("images/menu.png"),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.8),
              ],
            ),
            image: DecorationImage(
              image: AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 300,
                    height: 100,
                    child: Center(
                        child: Image.asset(
                      'images/dakiba_logo.png',
                      width: 300,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child: Center(
                      child: Text(
                        "WELCOME TO PLANWEY\n OUR PARTY SERVICES",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: AppTheme().color_white,
                            fontFamily: "MontBlancDemo-Bold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 70, right: 70),
                  child: Container(
                    height: 1,
                    color: AppTheme().color_white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30,
                      left: 15,
                      right: 15),
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    child: Text(
                      "We are well-experienced in what it takes to arrange and execute a successful event whether it's large or small, casual or formal. Don't worry about the effort of arranging an ideal one. Whether you are planning a party for five or a corporate function for 5000, Dakibaa is here to help you make your next event a grand success. Dakibaa, your event party planner is ready to offer all party supplies from your beverage order to glassware, bartenders and butler services.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: AppTheme().color_white,
                          fontFamily: "Montserrat-SemiBold"),
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20,
                      left: 15,
                      right: 15),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme().color_white,
                        //borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Image.asset('images/house.jpg'),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "InHouse Party",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: AppTheme().color_white,
                            fontFamily: "MontBlancDemo-Bold"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20,
                      left: 15,
                      right: 15),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme().color_white,
                        //borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Image.asset('images/corpteparty.jpg'),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "CORPORATE PARTY",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppTheme().color_white,
                          fontFamily: "MontBlancDemo-Bold"),
                    ),
                  )),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Number_of_Person()));
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => Number_of_Person()),
                        //     (Route<dynamic> route) => false);
                      },
                      child: new Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppTheme().color_red),
                        child: new Center(
                          child: Text(
                            "Book Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme().color_white,
                                fontFamily: "MontBlancDemo-Bold"),
                          ),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
