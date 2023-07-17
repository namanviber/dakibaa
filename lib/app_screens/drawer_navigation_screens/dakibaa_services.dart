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
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                height: 18,
                child: Image.asset(
                  "images/back_button.png",
                ),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
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
