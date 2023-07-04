import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'rest_api/ApiList.dart';
import 'app_screens/drawer_navigation_screens/faq_screen.dart';
import 'home_page.dart';
import 'app_screens/authorization_screens/login_pagenew.dart';


class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  @override
  bool status = false;
  String? _oldPasswordError;

  String? _passwordError;
  String? _confirmPasswordError;
  String? oldPassword;
  String? password;
  String? confirmPassword;
  final _formkey = GlobalKey<FormState>();
  bool passwordVisible=true;
  bool passwordVisible1=true;
  bool passwordVisible2=true;
  bool passwordVisible3=true;
  late ProgressDialog pr;
  Map<String, dynamic>? value;

  final TextEditingController oldPasswordController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  late SharedPreferences sharedPreferences;
  late var id;
  bool? checkValue;
  @override
  Widget build(BuildContext context) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    return Form(
      key: _formkey,
      child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child:Container(
              height: MediaQuery.of(context).size.height/1.04,
              decoration: BoxDecoration(
                  gradient: RadialGradient(

                      colors: [Colors.black.withOpacity(0.9)],
                      stops: [0.0, ]
                  ),
                  image: DecorationImage(
                    image: AssetImage("images/services_background.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  )
              ),
              child:  ListView(
                children: [
                  Column(
                    children: [
                      Container(

                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: new Row(
                                    children: [
                                      new InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: new Container(
                                          width: 30,
                                          height: 20,
                                          child: Image.asset("images/back_button.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left:0.0,top:MediaQuery.of(context).size.height/8,bottom: 0.0),
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: AppTheme().color_white,
                                            //fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat-SemiBold",
                                            fontSize: 32),
                                      )),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                ),

                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _oldPasswordError == null ? 0 : 10, left: 40),
                                  child: new Container(
                                      child: new Row(
                                        children: [
                                          Text(
                                            _oldPasswordError == null ? "" : _oldPasswordError!,
                                            style: TextStyle(
                                                color: AppTheme().color_white, fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().color_white,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  margin: EdgeInsets.only(left: 30.0,top: 8.0,right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      /* validator: (value){
                                      if(value.isEmpty){
                                        return "Enter old password";
                                      }
                                      else {
                                        return null;
                                      }
                                    },*/
                                      controller: oldPasswordController,
                                      onChanged: (values){
                                        setState(() {
                                          oldPassword=values;
                                        });
                                      },
                                      obscureText: passwordVisible,
                                      decoration: new InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: (){
                                              setState(() {
                                                passwordVisible = !passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )
                                        ),
                                        border: InputBorder.none,

                                        hintStyle: new TextStyle(color: AppTheme().color_red,
                                            fontSize: 18,fontFamily: "Montserrat-SemiBold"),
                                        hintText: "Old Password",
                                      ),


                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _passwordError == null ? 0 : 20, left: 40),
                                  child: new Container(
                                      child: new Row(
                                        children: [
                                          Text(
                                            _passwordError == null ? "" : _passwordError!,
                                            style: TextStyle(
                                                color: AppTheme().color_white, fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().color_white,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  margin: EdgeInsets.only(left: 30.0,top: 8.0,right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6),
                                    child: TextFormField(
                                      /*  validator: (value){
                                      if(value.isEmpty){
                                        return 'Enter new password';
                                      }

                                    },*/
                                      textAlign: TextAlign.center,
                                      controller: passwordController,
                                      onChanged: (values){
                                        setState(() {
                                          password=values;
                                        });
                                      },
                                      obscureText: passwordVisible1,
                                      decoration: new InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: (){
                                              setState(() {
                                                passwordVisible1 = !passwordVisible1;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible1
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )
                                        ),
                                        border:InputBorder.none,

                                        hintStyle: new TextStyle(color: AppTheme().color_red,
                                            fontSize: 18,fontFamily: "Montserrat-SemiBold"),
                                        hintText: "New Password",),


                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: _confirmPasswordError == null ? 0 : 20, left: 40),
                                  child: new Container(
                                      child: new Row(
                                        children: [
                                          Text(
                                            _confirmPasswordError == null ? "" : _confirmPasswordError!,
                                            style: TextStyle(
                                                color: AppTheme().color_white, fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme().color_white,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  margin: EdgeInsets.only(left: 30.0,top: 8.0,right: 30.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/13),
                                    child: TextFormField(
                                      /*validator: (value){
                                      if(value.isEmpty){
                                        return 'Please confirm your password';
                                      }
                                      if(value!=passwordController.text){
                                        return 'Password is not matching';
                                      }
                                    },*/
                                      controller: confirmPasswordController,
                                      onChanged: (values){
                                        setState(() {
                                          confirmPassword=values;
                                        });
                                      },
                                      obscureText: passwordVisible2,
                                      textAlign: TextAlign.center,
                                      decoration: new InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: (){
                                              setState(() {
                                                passwordVisible2 = !passwordVisible2;
                                              });
                                            },
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.red,
                                            )
                                        ),
                                        border: InputBorder.none,

                                        hintStyle: new TextStyle(color: AppTheme().color_red,
                                            fontSize: 18,fontFamily: "Montserrat-SemiBold"),
                                        hintText: "Confirm New Password",),


                                    ),
                                  ),
                                ),


                                Container(

                                  margin: EdgeInsets.only(left: 10.0,top: 30.0,right: 10.0),
                                  child: ButtonTheme(

                                    minWidth: 150.0,
                                    height: 50,
                                    child: ElevatedButton(
                                        child: Text("SUBMIT",
                                          style: TextStyle(color:AppTheme().color_white,
                                              fontWeight: FontWeight.bold, fontSize: 17,fontFamily: "Montserrat"),),
                                        onPressed: () {
                                          getData();
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )
          )),
    );
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          id = sharedPreferences.getString("id");
        } else {

          id.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
  bool ChangePasswordValidation() {
    setState(() {
      status = true;
    });

    _oldPasswordError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    if (oldPassword == "" || oldPassword == null) {
      setState(() {
        _oldPasswordError = 'Enter Old Password';
        status = false;
      });
    }
    if (password == "" || password == null) {
      setState(() {
        _passwordError = 'Enter New Password';
        status = false;
      });
    }else if (password!.length < 8) {
      setState(() {
        _passwordError = 'Enter minimum 8 characters';
        status = false;
      });
    }
    if (password !=confirmPassword ) {
      setState(() {
        _confirmPasswordError = 'Password not Match';
        status = false;
      });
    }
    return status;
  }
  var returnData;

  Future<Map<String, dynamic>> getData() async {
    print(id.toString());
    print(oldPasswordController.text);
    print(passwordController.text);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    if(ChangePasswordValidation()){
      pr.show();
      final response = await http.post(APIS.changePassword,
          headers: {'Accept': 'application/json'},
          body: {"id":id.toString(),
            "oldpassword": oldPasswordController.text,
            "password": passwordController.text});
      print(response.body);
      var parsedJson = json.decode(response.body);
      value = parsedJson['data'];
      print("Status = " + parsedJson['status']);
      if (parsedJson['status'] == "1") {
        pr.hide();
        Toast.show("" + parsedJson['message'], context,
            duration: Toast.lengthLong, gravity: Toast.bottom,);
        //_onChanged(value);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            LoginPage()), (Route<dynamic> route) => false);
      } else {
        pr.hide();
        Toast.show("" + parsedJson['message'], context,
            duration: Toast.lengthLong, gravity: Toast.bottom,);

      }
      return parsedJson;
    }
    return returnData;

  }
  @override
  void initState() {
    getCredential();
    passwordVisible = true;
    passwordVisible1 = true;
    passwordVisible2 = true;
    passwordVisible3 = true;
  }
}

