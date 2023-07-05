import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_dakibaa.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  _myApp createState() => new _myApp();
}

class _myApp extends  State<MyApp>{
  var mail;
  bool? checkValue;
  SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    getCredential();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'DAKIBA',
      debugShowCheckedModeBanner: false,
      home:AboutDakibaa(),
    );
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        checkValue = sharedPreferences!.getBool("check") ?? false;
        if (checkValue == null || checkValue == false) {
          sharedPreferences!.clear();
        } else {
          mail = sharedPreferences!.getString("email");

        }
      });
    }
  }
}

