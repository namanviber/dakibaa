import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dakibaa/rest_api/ApiList.dart';
import 'package:http/http.dart' as http;
import 'package:dakibaa/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

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
    http.Response response = await http.post(Uri.parse(APIS.OrderHistory),
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
        // getCount();
        _isProgressBarShown = false;
      });
      Toast.show(""+data!["message"],
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
      body: Container(
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
              image: const AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Image.asset("images/back_button.png",width: 20,height: 20,),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Order History",style: TextStyle(
              color: AppTheme().colorWhite,
              fontFamily: "Montserrat",
              fontSize: 30
            ),),
          listData==null?Expanded(child: ListView(
              children: [
                itemLoading()
              ],
            ),
            ):data!["status"]=="0"?
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text("No Data Found",style: TextStyle(
                      color: AppTheme().colorWhite,
                      fontSize: 25,
                      fontFamily: "Montserrat-SemiBold"
                  ),),
                ),
              ),
            ) :Expanded(child:  ListView.builder(
               shrinkWrap: true,
               itemCount: listData!.isEmpty?0:listData!.length,
               itemBuilder: (context,index){
                 return Padding(
                   padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                   child: Container(

                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           color: AppTheme().colorWhite,
                           borderRadius: BorderRadius.circular(15),
                         boxShadow: const [BoxShadow(
                             color: Colors.black, blurRadius: 5, )]
                       ),
                       child: Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(top: 10,left: 20),
                             child: Row(
                               children: [
                                 Expanded(
                                   flex: 2,
                                   child: Text("Name",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(
                                   flex: 1,
                                   child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(
                                   flex: 3,
                                   child:  Text(listData![index]["Name"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(
                                   flex: 2,
                                   child: Text("Contact No",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["phone"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                           listData![index]["pincode"]==null?Container(): Padding(
                             padding: const EdgeInsets.only(top: 5,left: 20),
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Pincode",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["pincode"],style: TextStyle(
                                     color: AppTheme().colorBlack,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),


                               ],
                             ),
                           ),
                           listData![index]["pincode"]==null?Container(): Padding(
                             padding: const EdgeInsets.only(top: 5),
                             child: Container(
                               height: 1,
                               color: Colors.grey[300],
                             ),
                           ),
                           listData![index]["city"]==null?Container():Padding(
                             padding: const EdgeInsets.only(top: 5,left: 20),
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("City",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                  Expanded(flex: 3,child:  Text(listData![index]["city"],style: TextStyle(
                                     color: AppTheme().colorBlack,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),)


                               ],
                             ),
                           ),
                           listData![index]["pincode"]==null?Container():Padding(
                             padding: const EdgeInsets.only(top: 5),
                             child: Container(
                               height: 1,
                               color: Colors.grey[300],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 5,left: 20),
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Address",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["address"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Date",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["date"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Time",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["time"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Quantity",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["qty"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Product",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["productname"],style: TextStyle(
                                     color: AppTheme().colorBlack,
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
                             child: Row(
                               children: [
                                 Expanded(flex: 2,child: Text("Amount",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 1,child: Text(":",style: TextStyle(
                                     color: AppTheme().colorRed,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),),
                                 Expanded(flex: 3,child:  Text(listData![index]["total"],style: TextStyle(
                                     color: AppTheme().colorBlack,
                                     fontSize: 17,
                                     fontFamily: "Montserrat-SemiBold"
                                 ),),)


                               ],
                             ),
                           ),
                         ],
                       )
                   ),
                 );
               }))
          ],
        ),
      ),
    );
  }
  Widget itemLoading() {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
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
