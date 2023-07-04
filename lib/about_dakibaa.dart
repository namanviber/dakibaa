import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/app_screens/authorization_screens/login_pagenew.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:partyapp/widgets/appDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/constant.dart';

class AboutDakibaa extends StatefulWidget {
  @override
  _AboutDakibaaState createState() => _AboutDakibaaState();
}

class _AboutDakibaaState extends State<AboutDakibaa> {
  var name, email, id, gender, mobile, noperson, phone, dob;
  late SharedPreferences sharedPreferences;
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
      if (checkValue == null || checkValue == false) {
        sharedPreferences.clear();
        sharedPreferences.setBool("check", false);
        checkValue = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
      ),
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
                        if (checkValue!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Number_of_Person()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
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
