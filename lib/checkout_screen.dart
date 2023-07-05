// ignore_for_file: missing_return

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/constant.dart';
import 'package:dakibaa/number_of_person.dart';
import 'package:dakibaa/paytm_screen.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'rest_api/ApiList.dart';
import 'home_page.dart';


class CheckOutScreen extends StatefulWidget {
  String? id_list;
  var price;
  CheckOutScreen({this.price,this.id_list});

  @override
  State createState() => new _CheckOutScreen(price: price,id_list: id_list);
}

class _CheckOutScreen extends State<CheckOutScreen> {
  String? id_list;
  var price;
  _CheckOutScreen({this.price,this.id_list});
  late ProgressDialog pr;
  late SharedPreferences sharedPreferences;
  var id;
  var finaldate;
  bool? checkValue;
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic>? value;
  @override
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final controllereController = TextEditingController();
  final timeController = TextEditingController();
  TimeOfDay? timePicked1;
  TimeOfDay? _timeOfDay1=TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  Widget build(BuildContext context) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    return Scaffold(
        body: GestureDetector(
          onTap: () {

            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Form(
            key: _formkey,
            child: Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(

                        colors: [Colors.black.withOpacity(0.9)],
                        stops: [0.0, ]
                    ),
                    image: DecorationImage(
                      image: AssetImage("images/signup_background.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    )
                ),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      /*Container(
                        height: 100.0,
                        width: 120.0,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Image.asset("images/party.png"),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(top: 30,left: 20),
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
                      Container(

                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(left:0.0,top:50.0,bottom: 0.0),
                          child: Text(
                            'CHECK OUT',
                            style: TextStyle(
                                color: AppTheme().color_white,
                                //fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontSize: 25),
                          )),





                      Container(
                        margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),

                        child: TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter name";
                            }
                            else {
                              return null;
                            }
                          },
                          controller: nameController,
                          decoration: new InputDecoration(

                              border: new OutlineInputBorder(
                                borderSide: BorderSide(width: 1,color: Colors.white),

                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              wordSpacing: 1.0,
                            ),
                              contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

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
                              filled: true,
                              hintStyle: new TextStyle(color: AppTheme().color_red,fontWeight: FontWeight.bold),
                              hintText: "Full Name",
                              fillColor: AppTheme().color_white),


                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0,top: 15.0,right: 20.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter email";
                            }
                            else  if(!regex.hasMatch(value)){
                              return "Enter Valid Email";
                            }else {
                              return null;
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[ ]"), allow: false)
                          ],
                           controller: mailController,
                          decoration: new InputDecoration(

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
                              errorStyle: TextStyle(
                                color: Colors.white,
                                wordSpacing: 1.0,
                              ),
                              contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

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
                              filled: true,
                              hintStyle: new TextStyle(color: AppTheme().color_red,fontWeight: FontWeight.bold),
                              hintText: "Email address",
                              fillColor: AppTheme().color_white),


                        ),
                      ),
                      Container(

                        margin: EdgeInsets.only(left: 20.0,top: 15.0,right: 20.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter number";
                            }else if(value.length != 10){
                              return "contact must be of 10 digits";
                            }
                            else {
                              return null;
                            }
                          },
                          controller: numberController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,

                          decoration: new InputDecoration(

                              border: new OutlineInputBorder(
                                borderSide: BorderSide(width: 1,color: Colors.white),

                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                borderSide: BorderSide(width: 1,color: Colors.white),
                              ),
                              contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

                              errorStyle: TextStyle(
                                color: Colors.white,
                                wordSpacing: 1.0,
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
                              filled: true,
                              hintStyle: new TextStyle(color: AppTheme().color_red,fontWeight: FontWeight.bold),
                              hintText: "Contact no.",
                              fillColor:AppTheme().color_white),


                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0,top: 15.0,right: 20.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter address";
                            }
                            else {
                              return null;
                            }
                          },
                            controller: addressController,
                          decoration: new InputDecoration(

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
                              contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                borderSide: BorderSide(width: 1,color: Colors.white),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.white,
                                wordSpacing: 1.0,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.white)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(width: 1,color: Colors.white)
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: AppTheme().color_red,fontWeight: FontWeight.bold),
                              hintText: "Address",
                              fillColor: AppTheme().color_white),


                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0,top: 15.0,right: 20.0),
                        child: InkWell(
                          onTap: (){
                            callDatePicker();
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          child: TextFormField(
                            textAlign:TextAlign.center,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter date";
                              }
                              else {
                                return null;
                              }
                            },
                            enabled: false,
                            controller: dateController,
                            decoration: new InputDecoration(

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
                                contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

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
                                hintStyle: new TextStyle(color: AppTheme().color_red,fontWeight: FontWeight.bold),
                                hintText: "Date",

                                fillColor: AppTheme().color_white),


                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0,top: 15.0,right: 20.0),
                        child: GestureDetector(
                          child: Container(
                            
                            child: InkWell(
                              onTap: (){
                                getStartTime(context);
                              },
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter time";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                enabled: false,
                                 controller: timeController,
                                decoration: new InputDecoration(

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
                                    contentPadding: EdgeInsets.only(left:0.0,top: 5.0,bottom: 0.0),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      borderSide: BorderSide(width: 1,color: Colors.white),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.white,
                                      wordSpacing: 1.0,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        borderSide: BorderSide(width: 1,color: Colors.white)
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        borderSide: BorderSide(width: 1,color: Colors.white)
                                    ),
                                    filled: true,
                                    hintStyle: new TextStyle(color:AppTheme().color_red,fontWeight: FontWeight.bold),
                                    hintText: "Time",
                                    fillColor: AppTheme().color_white),


                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(

                        margin: EdgeInsets.only(left: 120.0,top: 25.0,right: 120.0),
                        child: ButtonTheme(
                          minWidth: 360.0,
                          child: ElevatedButton(
                              child: Text("SUBMIT"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme().color_red,
                                textStyle: TextStyle(color:AppTheme().color_red,fontWeight: FontWeight.bold,fontSize: 17),
                              ),
                              onPressed: (){
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  setState(() {});
                                  getData();

                                };
                              },
                          ),
                        ),
                      ),

                    ],
                  )),
            ),
          ),
        ));
  }
  Future<Map<String, dynamic>> getData() async {
    //  print(myController1.text);
    pr = new ProgressDialog(context: context, );
    pr.show();
    // print(token);
  /*  Map<String, dynamic> body = {
      "Name": nameController.text.toString(),
      "phone": numberController.text.toString(),
      "address": addressController.text.toString(),
      "date": dateController.text.toString(),
      "time": timeController.text.toString(),
      "order": jsons,
      "userid": id.toString(),
      "person": person.toString()
    };*/
    final response = await http.post(Uri.parse(APIS.orderDetails),
        headers: {'Accept': 'application/json'},
        body:{
          "Name": nameController.text.toString(),
          "Email": nameController.text.toString(),
          "phone": numberController.text.toString(),
          "address": addressController.text.toString(),
          "date": dateController.text.toString(),
          "time": timeController.text.toString(),
          "order": jsons,
          "userid": id.toString(),
          "person": person.toString()
        });
    print("json  :  "+jsons.toString());
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.close();
      setState(() {
        id_com= id.toString();
       // _onChanged(true, value);
      });
      Toast.show("" + parsedJson['message'],
          duration: Toast.lengthShort, gravity: Toast.bottom,);
     /* sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove("price");*/
      //_onChanged(value);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          Paytmscreen()));
    } else {
      pr.close();
      Toast.show("" + parsedJson['message'],
          duration: Toast.lengthShort, gravity: Toast.bottom,);

    }
    return parsedJson;
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          id = sharedPreferences.getString("id");
          print(id);
        } else {
          id.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
      var formatter = new DateFormat('dd-MMM-yyyy');
      String formatted = formatter.format(finaldate);
      print(formatted);
      dateController.text=formatted.toString();
    });
  }
  Future<Null> getStartTime(BuildContext context) async {
    // Imagine that this function is
    // more complex and slow.
    timePicked1=await showTimePicker(
      context: context,
      initialTime:_timeOfDay1!=null?_timeOfDay1!:TimeOfDay.now(),
    );
    setState(() {
      _timeOfDay1=timePicked1;
      timeController.text=_timeOfDay1!.format(context).toString();
      print(_timeOfDay1!.format(context));
      print(timePicked1);
    });
  }
/*  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
      var formatter = new DateFormat('dd-MMM-yyyy');
      String formatted = formatter.format(finaldate);
      print(formatted);
      dateController.text=formatted.toString();
    });
  }*/
  Future<DateTime?> getDate()  {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
  }
}

