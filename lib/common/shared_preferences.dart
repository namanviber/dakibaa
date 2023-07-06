import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass{

  Future<void> setloginstatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login_status',status);
  }
  Future<bool>getloginstatus() async {
    SharedPreferences getloginprefs = await SharedPreferences.getInstance();
    return getloginprefs.getBool('login_status')!;
  }

  Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email',email);
  }
  Future<String>getEmail() async {
    SharedPreferences getloginprefs = await SharedPreferences.getInstance();
    return getloginprefs.getString('email')!;
  }

  Future<void> setName(String name) async {
    SharedPreferences nameprefs = await SharedPreferences.getInstance();
    nameprefs.setString('name',name);
  }
  Future<String>getName() async {
    SharedPreferences getnameprefs = await SharedPreferences.getInstance();
    return getnameprefs.getString('name')!;
  }
  Future<void> setlogininid(String signinid) async {
    SharedPreferences logininid = await SharedPreferences.getInstance();
    logininid.setString('signinid',signinid);
  }
  Future<String>getlogininid() async {
    SharedPreferences logininid = await SharedPreferences.getInstance();
    return logininid.getString('signinid')!;
  }
  Future<void> setphoneno(String mobileno) async {
    SharedPreferences phoneno = await SharedPreferences.getInstance();
    phoneno.setString('mobileno',mobileno);
  }
  Future<String>getphoneno() async {
    SharedPreferences phoneno = await SharedPreferences.getInstance();
    return phoneno.getString('mobileno')!;
  }

  Future<void> settoken(String token) async {
    SharedPreferences tokenprefs = await SharedPreferences.getInstance();
    tokenprefs.setString('token',token);
  }
  Future<String>gettoken() async {
    SharedPreferences gettokenprefs = await SharedPreferences.getInstance();
    return gettokenprefs.getString('token')!;
  }





}