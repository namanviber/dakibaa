import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'ApiList.dart';
import 'home_page.dart';

class ContactUs extends StatefulWidget {
  @override
  ContactUsPage createState() => ContactUsPage();
}

class ContactUsPage extends State<ContactUs> {
  AnimationController? _controller;
  File? _image;
  bool status = false;
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  Map<String, dynamic>? value1;
  List<dynamic>? listData;
  bool mesg=false;
  Map? data;
  var name;
  var mail;
  var address;
  late var number;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();



  Future<Map<String, dynamic>> getData() async {
    //  print(myController1.text);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    // print(token);
    final response = await http.post(APIS.addMessage,
        headers: {'Accept': 'application/json'},
        body: {"name": nameController.text,
          "email": emailController.text,
        "message":messageController.text});
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
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

  Future getContact() async   {
    // _isProgressBarShown = true;
    http.Response response = await http
        .get(APIS.ownerDetail);
    var datatc = json.decode(response.body);
    setState(() {
      name=datatc['data']['Name']??'';
      mail=datatc['data']['Email']??'';
      address=datatc['data']['Address']??'';
      number=datatc['data']['Mobile']??'';

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
    /*Random rnd = new Random();
    int sum=0;
    var orderno = rnd.nextInt(10);
    print(orderno);
    sum=orderno+1*6;
    print(sum);*/
  }
  @override
  Widget build(BuildContext context) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
        key: _formkey,
        child: Container(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
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
              child:  Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.bottomCenter,
                child: ListView(
                  children: <Widget>[
                   new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0,left: 20),
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
                              padding: EdgeInsets.only(
                                left: 0.0,
                                right: 0.0,
                                top: 10.0,
                              ),
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    "images/contact_logo.png",
                                    fit: BoxFit.fill,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                          child: Center(
                            child: Text(
                              "Contact us",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: "Montserrat"
                                //fontWeight: FontWeight.w600,
                                //letterSpacing: 1
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 20, 0, 5),
                          child: Center(
                            child: Text(
                              "Feel Free To Drop Us a Message Or Call",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontFamily: "Montserrat-SemiBold"
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: mesg==false
                              ?MediaQuery.of(context).size.height/7:0),
                          child: GestureDetector(
                            onTap: (){
                              launch("tel://"+number);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppTheme().color_red,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                width: MediaQuery.of(context).size.width/2.6,
                                height: 45,
                                child:Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: new Row(
                                    children: [
                                      Image.asset("images/call.png",height: 20,width: 30,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Call Us",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppTheme().color_white,
                                          fontFamily: "Montserrat-SemiBold",
                                          fontSize: 20,
                                        ),

                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              mesg=true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme().color_red,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            width: MediaQuery.of(context).size.width/2.3,
                            height: 45,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: new Row(
                                children: [
                                  Image.asset("images/mesg.png",height: 20,width: 30,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Message",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme().color_white,
                                      fontFamily: "Montserrat-SemiBold",
                                      fontSize: 20,
                                    ),

                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        mesg==false
                            ?new Container()
                            :Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: AppTheme().color_white,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child:Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please enter name";
                                      }
                                      else {
                                        return null;
                                      }
                                    },

                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18,
                                        color: AppTheme().color_red,
                                        fontFamily: "Montserrat-SemiBold"),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Your Name*",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: AppTheme().color_red,
                                          fontFamily: "Montserrat-SemiBold"
                                      ),
                                      //contentPadding: EdgeInsets.only(top: 0)
                                    ),
                                    controller: nameController,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: AppTheme().color_white,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child:Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please enter email";
                                      }else if(!regex.hasMatch(value)){
                                        return "Enter Valid Email";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter(RegExp("[ ]"), allow: false)
                                    ],
                                    style: TextStyle(fontSize: 18,
                                        color: AppTheme().color_red,
                                        fontFamily: "Montserrat-SemiBold"),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Your Email*",
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: AppTheme().color_red,
                                          fontFamily: "Montserrat-SemiBold"
                                      ),

                                    ),
                                    controller: emailController,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child:new Container(

                                  decoration: BoxDecoration(
                                      color: AppTheme().color_white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child:Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Please enter message";
                                        }
                                        else {
                                          return null;
                                        }
                                      },

                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: TextStyle(fontSize: 18,
                                          color: AppTheme().color_red,
                                          fontFamily: "Montserrat-SemiBold"),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Your Message*",
                                        hintStyle: TextStyle(
                                            fontSize: 18.0,
                                            color: AppTheme().color_red,
                                            fontFamily: "Montserrat-SemiBold"
                                        ),
                                      ),
                                      controller: messageController,
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2.2,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    setState(() {});
                                    getData();

                                  };

                                },
                                child: Center(
                                  child:Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SEND",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontFamily: "Montserrat-SemiBold",
                                        fontSize: 20,
                                      ),

                                    ),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            /* Container(
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 45, 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "NAME: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Raleway",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        name==null? Text(
                                            ""
                                        ):
                                        Text(
                                          " $name",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Raleway",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "EMAIL ID: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Raleway",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        mail==null?  Text(
                                            ""
                                        ):
                                        Text(
                                          " $mail",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Raleway",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  color: Colors.white,
                                  child: GestureDetector(
                                    onTap: (){
                                      launch("tel://"+number);
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.fromLTRB(8, 8,8, 8),
                                      child: Image.asset(
                                        "images/call.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "ADDRESS: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              address==null?Text(
                                  ""
                              ):
                              Text(
                                " $address ",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )*/
                          ],
                        )
                      ],
                    )

                  ],
                ),
              )

            ),
          ),
        ),
      ),
    );
  }
}
