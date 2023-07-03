import 'package:flutter/material.dart';

import 'Colors/colors.dart';


class DakibaaServices extends StatefulWidget {
  @override
  _DakibaaServicesState createState() => _DakibaaServicesState();
}

class _DakibaaServicesState extends State<DakibaaServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
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
        child: new ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 30,left: 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: new Container(
                            height: 18,
                            child: new Image.asset(
                              "images/back_button.png",
                            ),
                          ),
                        )
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child: Center(
                      child: Text("Provide Services",textAlign:TextAlign.center,style: TextStyle(
                          fontSize: 25,
                          color: AppTheme().color_white,
                          fontFamily: "Montserrat"
                      ),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/20,left: 15,right: 15),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme().color_white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                        child: Text("We provide the logistics like Bartender, Butler, Glassware and beverages Services based on the request raised by our customers for In-house parties or corporate social gatherings. Our services are highly flexible. We have the expertise and potential to manage logistics as per last moment needs as well. Every party ends up with an enlighten mood and has many stories of people interactions. We want our guest to create and enjoy the stories, rest will be taken care by Dakibaa.",
                          textAlign:TextAlign.center,style: TextStyle(
                              fontSize: 18,
                              color: AppTheme().color_red,
                              fontFamily: "Montserrat-SemiBold"
                          ),
                        ),
                      )
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
