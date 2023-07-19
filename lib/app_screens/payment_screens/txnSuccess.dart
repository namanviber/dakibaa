import 'package:dakibaa/app_screens/home_screens/about_dakibaa.dart';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appButton.dart';
import 'package:flutter/material.dart';
import '../../Colors/colors.dart';

class ThankYouScreen extends StatelessWidget {
  String OrderID;
  ThankYouScreen({required this.OrderID, super.key});
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: AppTheme().colorBlack,
          body: AppBody(
            imgPath: "images/services_background.jpg",
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset('images/thumsup.gif'),
                ),
                Text(
                  "Thank You",
                  style: TextStyle(
                      color: AppTheme().colorWhite,
                      fontSize: 35,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "We will Contact You Soon",
                  style: TextStyle(
                      color: AppTheme().colorWhite,
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Order ID :  $OrderID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontSize: 15,
                          fontFamily: 'Montserrat-SemiBold'),
                    ),
                  ],
                ),
                AppButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => AboutDakibaa()),
                          (Route<dynamic> route) => false);
                    },
                    title: "OK"),
              ],
            ),
          ),
        ));
  }
}
