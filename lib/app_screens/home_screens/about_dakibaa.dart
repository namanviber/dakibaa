import 'package:dakibaa/widgets/appButton.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/app_screens/authorization_screens/signIn.dart';
import 'package:dakibaa/app_screens/home_screens/guestCount.dart';
import 'package:dakibaa/widgets/appDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutDakibaa extends StatefulWidget {
  @override
  _AboutDakibaaState createState() => _AboutDakibaaState();
}

class _AboutDakibaaState extends State<AboutDakibaa> {
  var name, email, id, gender, mobile, noperson, phone, dob;
  late SharedPreferences sharedPreferences;
  bool? checkValue;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCredential();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check") ?? false;
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
      drawer: AppDrawer(),
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
              image: const AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
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
                  child: Center(
                    child: Text(
                      "WELCOME TO PLANWEY\n OUR PARTY SERVICES",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: AppTheme().colorWhite,
                          fontFamily: "MontBlancDemo-Bold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 70, right: 70),
                  child: Container(
                    height: 1,
                    color: AppTheme().colorWhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30,
                      left: 15,
                      right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    child: Text(
                      "We are well-experienced in what it takes to arrange and execute a successful event whether it's large or small, casual or formal. Don't worry about the effort of arranging an ideal one. Whether you are planning a party for five or a corporate function for 5000, Dakibaa is here to help you make your next event a grand success. Dakibaa, your event party planner is ready to offer all party supplies from your beverage order to glassware, bartenders and butler services.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: AppTheme().colorWhite,
                          fontFamily: "Montserrat-SemiBold"),
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
                        color: AppTheme().colorWhite,
                        //borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Image.asset('images/house.jpg'),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "InHouse Party",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppTheme().colorWhite,
                          fontFamily: "MontBlancDemo-Bold"),
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
                        color: AppTheme().colorWhite,
                        //borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Image.asset('images/corpteparty.jpg'),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "CORPORATE PARTY",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppTheme().colorWhite,
                          fontFamily: "MontBlancDemo-Bold"),
                    ),
                  ),
                ),
                AppButton(
                  onPressed: () {
                    if (checkValue!) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const Number_of_Person()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }
                  },
                  title: "Book Now",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),),
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
