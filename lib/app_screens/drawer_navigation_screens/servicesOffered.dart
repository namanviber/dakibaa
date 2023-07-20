import 'package:dakibaa/widgets/appBody.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';

class DakibaaServices extends StatefulWidget {
  const DakibaaServices({super.key});

  @override
  State<DakibaaServices> createState() => _DakibaaServicesState();
}

class _DakibaaServicesState extends State<DakibaaServices> {
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
            children: <Widget>[
              const SizedBox(height: 70,),
              Center(
                child: Text(
                  "Services Provided",
                  style: TextStyle(
                      fontSize: 25,
                      color: AppTheme().colorWhite,
                      fontFamily: "Montserrat"),
                ),
              ),
              //
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
                        "We provide the logistics like Bartender, Butler, Glassware and beverages Services based on the request raised by our customers for In-house parties or corporate social gatherings. Our services are highly flexible. We have the expertise and potential to manage logistics as per last moment needs as well. Every party ends up with an enlighten mood and has many stories of people interactions. We want our guest to create and enjoy the stories, rest will be taken care by Dakibaa.",
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
