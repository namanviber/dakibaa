import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'app_screens/home_screens/about_dakibaa.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  _myApp createState() => _myApp();
}

class _myApp extends  State<MyApp>{
  var mail;
  bool? checkValue;
  SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);//-> This part
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

