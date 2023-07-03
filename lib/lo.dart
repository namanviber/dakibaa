import 'dart:convert';
import 'package:partyapp/signup_pagenew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:party_app/forget_password.dart';


import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import 'ApiList.dart';
import 'Services.dart';
import 'forget_password.dart';
import 'home_page.dart';
class LoginPageGradient extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageGradient> {
  double screenHeight;
  double screenwidth;
  bool checkValue = false;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  ProgressDialog pr;
  Map<String, dynamic> value;
  SharedPreferences sharedPreferences;
  bool passwordVisible1=true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   // screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return  Scaffold(
     // backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: GestureDetector(
        onTap: () {

          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child:
              Container(
                decoration: new BoxDecoration(
                    gradient: LinearGradient(

                        colors: [
                          Colors.orange,
                          Colors.orange,

                        ])
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.only(top: 40.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 12.0),
                        child: Text("House Party",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 25.0,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 1
                          ),),
                      ),
                      Container(
                        height: 65.0,
                        margin: EdgeInsets.only(left: 20.0,top: 120.0,right: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(width: 1,color: Colors.purple),

                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),

                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.purple)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.purple)
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.purple[800],fontWeight: FontWeight.bold),
                              hintText: "LOG IN/USER NAME",
                              fillColor: Colors.white70),


                        ),
                      ),
                      Container(
                        height: 65.0,
                        margin: EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          controller: passwordController,
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
                                    color: Colors.purple,
                                  )
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 1,color: Colors.purple),
                              ),

                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.purple)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.purple)
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.purple[800],fontWeight: FontWeight.bold),
                              hintText: "PASSWORD",

                              fillColor: Colors.white70),
                        ),
                      ),
                      Container(

                          margin: EdgeInsets.only(top: 13.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPass()),
                              );
                            },
                            child: Text("Forgot Password ?",
                              style: TextStyle(fontSize: 16.0,color:Colors.white),),
                          )),


                      GestureDetector(
                        onTap: () {

                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0,left: 20,right: 20),
                          child: ButtonTheme(

                            minWidth: 360.0,
                            child: ElevatedButton(
                                child: Text("LOG IN",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 17,letterSpacing: 2),),
                                onPressed: () {


                                  if (_formkey.currentState.validate()) {
                                    _formkey.currentState.save();
                                    setState(() {});
                                    getData();
                                  }
                                  /*    if (_formkey.currentState.validate()) {
                                  _formkey.currentState.save();
                                  setState(() {});
                                  UsernameController.text;
                                  UserPasswordController.text;
                                }else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                }*/

                                }
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0,left: 20,right: 20),
                        child: ButtonTheme(
                          minWidth: 360.0,
                          child: ElevatedButton(
                              child: Text("GUEST LOG IN",
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 17,letterSpacing: 2),),
                              onPressed: () {
                                setGuest();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              }
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 13.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                            child: Text("New User ? SignUp",
                              style: TextStyle(fontSize: 17.0,color:Colors.white,fontWeight: FontWeight.w400),),
                          ))
                    ],
                  ),
                ),
              )



        ),
      ),
    );
  }
  Future<Map<String, dynamic>> getData() async {
    //  print(myController1.text);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    // print(token);
    final response = await http.post(APIS.usersLogin,
        headers: {'Accept': 'application/json'},
        body: {"username": usernameController.text,
          "password": passwordController.text});
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
      setState(() {
        _onChanged(true, value);
      });
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      //_onChanged(value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    }
    return parsedJson;
  }

  _onChanged(bool value, Map<String, dynamic> response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("name", response["Name"]);
      sharedPreferences.setString("id", response["Id"].toString());
      /* sharedPreferences.setString("gender", response["Gender"]);
      sharedPreferences.setString("dob", response["DOB"]);*/
      sharedPreferences.setString("mobile", response["Mobile"]);
      /*  sharedPreferences.setString("email", response["Email"]);*/
      sharedPreferences.setString("password", response["Password"]);
      sharedPreferences.setString("profile_pic", response["ProfilePic"]);
      sharedPreferences.commit();
    });
  }
  setGuest() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
      sharedPreferences.setBool("check", true);
      sharedPreferences.setString("id", "");
    });
  }
  @override
  void initState() {
    passwordVisible1 = true;
  }
}