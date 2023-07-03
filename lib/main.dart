import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partyapp/about_dakibaa.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'home_page.dart';
import 'lo.dart';
import 'login_pagenew.dart';

Future<void> main() async {
 // GestureBinding.instance?.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _myApp createState() => new _myApp();
}

class _myApp extends  State<MyApp>{
  // This widget is the root of your application.
  late var mail;
  bool? checkValue;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    getCredential();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'DAKIBA',
      debugShowCheckedModeBanner: false,
      home:AboutDakibaa(),
      //home:  mail == null? AboutDakibaa() : Number_of_Person(),
    );
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        checkValue = sharedPreferences.getBool("check");
        if (checkValue != null) {
          if (checkValue!) {
            mail = sharedPreferences.getString("email");
          }
          else {
            mail.clear();
            sharedPreferences.clear();
          }
        } else {
          checkValue = false;
        }
      });
    }
  }
}

