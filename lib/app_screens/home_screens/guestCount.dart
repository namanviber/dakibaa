import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appTextField.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/app_screens/home_screens/availableServices.dart';
import 'package:dakibaa/common/constant.dart';
import 'package:dakibaa/widgets/appDrawer.dart';

import '../../widgets/appButton.dart';

class Number_of_Person extends StatefulWidget {
  const Number_of_Person({super.key});

  @override
  State<Number_of_Person> createState() => _Number_of_PersonState();
}

class _Number_of_PersonState extends State<Number_of_Person> {
  var pr;

  double? screenHeight;

  double? screenwidth;

  bool status = false;

  bool? checkValue;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? personError;

  TextEditingController personContoller = TextEditingController();

  var name, email, id, gender, mobile, noperson, phone, dob;

  bool validation() {
    personError = null;
    if (noperson == null || noperson == "") {
      setState(() {
        personError = 'Enter Person';
        status = false;
      });
    } else if (noperson == "0") {
      setState(() {
        personError = 'Enter Number of Person ';
        status = false;
      });
    } else {
      setState(() {
        status = true;
      });
    }
    return status;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      noperson = "15";
      person = int.parse(noperson);
      personContoller.text = "15";
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme().colorBlack,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: AppBody(
        imgPath: "images/services_background.jpg",
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
                ),
                child: Center(
                    child: Text(
                  "Planning for Party !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppTheme().colorWhite,
                      fontSize: 25,
                      fontFamily: "Montserrat"),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Center(
                    child: Text(
                  "Number of Guests",
                  style: TextStyle(
                      color: AppTheme().colorWhite,
                      fontSize: 22,
                      fontFamily: "Montserrat-SemiBold"),
                )),
              ),
              AppTextField(
                  validator: (value) {},
                  controller: personContoller,
                  hinttext: "Enter No. of Persons"),
              AppButton(
                onPressed: () {
                  if (validation()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Services()));
                  }
                },
                title: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
