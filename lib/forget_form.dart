 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'rest_api/ApiList.dart';
import 'app_screens/authorization_screens/login_pagenew.dart';
import 'otp_screen.dart';

class ForgetForm extends StatefulWidget {

  String? number;
  ForgetForm({this.number});
  @override
  _ForgetForm createState() => _ForgetForm(number: number);
}

class _ForgetForm extends State<ForgetForm> {
  String? number;
  _ForgetForm({this.number});
  @override
  final new_PasswordController = TextEditingController();
  final confirmNew_PasswordController = TextEditingController();
  late ProgressDialog pr;
  Map<String, dynamic>? value;
bool passwordVisible=true;
bool passwordVisible1=true;
  final _formkey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () {

            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(

                  colors: [Colors.black.withOpacity(0.8),Colors.black.withOpacity(0.8),],

                ),
                image: DecorationImage(
                  image: AssetImage("images/services_background.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                )
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(

                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top:10.0,bottom: 15.0),
                        child: Text(
                          'FORGOT PASSWORD',
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 22),
                        )),
                    SizedBox(height: 40.0),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10.0, top: 20.0),
                        child: Text(
                          'Create a new and unique password',
                          style: TextStyle(fontSize: 16,color: AppTheme().color_white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10.0, top: 0.0),
                        child: Text(
                          'for your account',
                          style: TextStyle(fontSize: 16,color: AppTheme().color_white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat"),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 20.0,left: 170.0,right: 170.0,),
                      alignment: Alignment.center,
                      child: Divider(height: 2.0,thickness: 2.0,color: Colors.white,),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                       Container(
                          margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            obscureText: passwordVisible,
                            controller: new_PasswordController,
                            style: new TextStyle(color: AppTheme().color_red,
                                fontFamily: "Montserrat-SemiBold"),
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

                                border: new OutlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.white),

                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.white),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.white),
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(width: 1,color: Colors.white)
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.white,
                                  wordSpacing: 1.0,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(width: 1,color: Colors.white)
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: AppTheme().color_red,
                                    fontFamily: "Montserrat-SemiBold"),
                                hintText: "New Password",
                                fillColor: AppTheme().color_white),


                          ),
                        ),
                          Container(

                            margin: EdgeInsets.only(left: 20.0,top: 25.0,right: 20.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if(value!=new_PasswordController.text){
                                  return 'Password is not matching';
                                }
                                return null;
                              },
                              style: new TextStyle(color: AppTheme().color_red,
                                  fontFamily: "Montserrat-SemiBold"),
                              textAlign: TextAlign.center,
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
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,color: Colors.white),

                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(50.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(width: 1,color: Colors.white),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(width: 1,color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(width: 1,color: Colors.white),
                                  ),

                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      borderSide: BorderSide(width: 1,color: Colors.white)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      borderSide: BorderSide(width: 1,color: Colors.white)
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.white,
                                    wordSpacing: 1.0,
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: AppTheme().color_red,
                                      fontFamily: "Montserrat-SemiBold"),
                                  hintText: "Confirm New Password",
                                  fillColor: AppTheme().color_white),


                            ),
                          ),
                        ]
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(left: 90.0,top: 25.0,right: 90.0),
                      child: Container(
                        height: 45,

                        //margin: EdgeInsets.only(left: 20.0,top: 25.0,right: 20.0),
                        child: ElevatedButton(
                            child: Text("SUBMIT",
                              style: TextStyle(color: AppTheme().color_white,fontWeight: FontWeight.bold,fontSize: 17),),
                            onPressed: (){
                              if (_formkey.currentState!.validate()) {
                                getData();
                              }

//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => ChangePassword()),
//                            );
                            },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
  @override
  void initState() {
    passwordVisible = true;
    passwordVisible1 = true;
  }
  Future<Map<String, dynamic>> getData() async {
      print(new_PasswordController.text);
      print(number);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    // print(token);
    final response = await http.post(APIS.forgetPassword,
        headers: {'Accept': 'application/json'},
        body: {"number": number.toString(),
          "password": new_PasswordController.text});
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
   /*   Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
      //_onChanged(value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(type:'forget')),
      );
    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);

    }
    return parsedJson;
  }
}

