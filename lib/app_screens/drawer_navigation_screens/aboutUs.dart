import 'package:dakibaa/widgets/appBody.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AppBody(
        imgPath: "images/services_background.jpg",
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 70,),
              Center(
                child: Text(
                  "About Us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: AppTheme().colorWhite,
                      fontFamily: "Montserrat"),
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
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: Text(
                        "Dakibaa is a team of experienced and passionate professionals who are dedicated to provide wide assortment of services specialized for In-house parties. We have all the required resources and expertise to manage a good range of corporate and personal events as well. We are working consistently to give a lasting experience to our customers and leave our honorable guest wowed with our best in class services. Dakibaa has a specialized team of Bartenders and Butlers. We also provide glassware & beverages Services for the parties. We are probably the best Party management organization in the business for your personal and corporate needs.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            color: AppTheme().colorRed,
                            fontFamily: "Montserrat-SemiBold"),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
