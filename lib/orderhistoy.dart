import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partyapp/rest_api/ApiList.dart';
import 'package:http/http.dart' as http;
import 'package:partyapp/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List? listData;
  bool _isProgressBarShown = true;
  Map? data;
  Map<String, dynamic>? value;
  bool? checkValue;
  var id;
  late SharedPreferences sharedPreferences;
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          id = sharedPreferences.getString("id");
          print(id);
          getData();
        } else {
          id.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http.post(APIS.OrderHistory,
        headers: {'Accept': 'application/json'},
        body: {"userid": id.toString(),});
    print(response.body);
    // var parsedJson = json.decode(response.body);
    // value = parsedJson['data'];
    data = json.decode(response.body);
    print(data.toString());
    if(mounted) {
      setState(() {
        listData = data!["data"];
        print("Response"+listData.toString());
        // getCount();
        _isProgressBarShown = false;
      });
      Toast.show(""+data!["message"], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);
    }

   // hasData = true;
    /*Toast.show(""+listData.toString(), context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredential();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          width:MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height/1,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.8),
              ],
            ),
            image: DecorationImage(
              image: AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: new Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 20),
              child: new Row(
                children: [
                  new InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: new Container(
                      child: new Image.asset("images/back_button.png",width: 20,height: 20,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            new Container(
              child: new Text("Order History",style: TextStyle(
                color: AppTheme().color_white,
                fontFamily: "Montserrat",
                fontSize: 30
              ),),
            ),
          listData==null?Expanded(child: new ListView(
              children: [
                itemLoading()
              ],
            ),
            ):data!["status"]=="0"?
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
              child: new Container(
                height: 50,
                child: new Center(
                  child: Text("No Data Found",style: TextStyle(
                      color: AppTheme().color_white,
                      fontSize: 25,
                      fontFamily: "Montserrat-SemiBold"
                  ),),
                ),
              ),
            ) :new Expanded(child:  new ListView.builder(
               shrinkWrap: true,
               itemCount: listData!.length==0?0:listData!.length,
               itemBuilder: (context,index){
                 return new Container(
                     child: Padding(
                       padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                       child: new Container(

                           width: MediaQuery.of(context).size.width,
                           decoration: BoxDecoration(
                               color: AppTheme().color_white,
                               borderRadius: BorderRadius.circular(15),
                             boxShadow: [BoxShadow(
                                 color: Colors.black, blurRadius: 5, )]
                           ),
                           child: new Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(top: 10,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(
                                       flex: 2,
                                       child: new Text("Name",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(
                                       flex: 1,
                                       child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(
                                       flex: 3,
                                       child:  new Text(listData![index]["Name"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)

                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(
                                       flex: 2,
                                       child: new Text("Contact No",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["phone"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)

                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               listData![index]["pincode"]==null?new Container(): Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Pincode",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["pincode"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),


                                   ],
                                 ),
                               ),
                               listData![index]["pincode"]==null?new Container(): Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               listData![index]["city"]==null?new Container():Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("City",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                      Expanded(flex: 3,child:  new Text(listData![index]["city"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               listData![index]["pincode"]==null?new Container():Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Address",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["address"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Date",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["date"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Time",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["time"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Quantity",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["qty"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Product",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["productname"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5),
                                 child: Container(
                                   height: 1,
                                   color: Colors.grey[300],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 5,left: 20,bottom: 10),
                                 child: new Row(
                                   children: [
                                     Expanded(flex: 2,child: new Text("Amount",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 1,child: new Text(":",style: TextStyle(
                                         color: AppTheme().color_red,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),),
                                     Expanded(flex: 3,child:  new Text(listData![index]["total"],style: TextStyle(
                                         color: AppTheme().color_black,
                                         fontSize: 17,
                                         fontFamily: "Montserrat-SemiBold"
                                     ),),)


                                   ],
                                 ),
                               ),
                             ],
                           )
                       ),
                     )
                 );
               }))
          ],
        ),
      ),
    );
  }
  Widget itemLoading() {
    return new Padding(
        padding: new EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: new Column(
              children: [
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
