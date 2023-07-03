import 'dart:convert';
import 'dart:io';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/ContactUs.dart';
import 'package:partyapp/EditProfile.dart';
import 'package:partyapp/Privacy.dart';
import 'package:partyapp/TermsCon.dart';
import 'package:partyapp/checkout_screen.dart';
import 'package:partyapp/desciption.dart';
import 'package:partyapp/faq_screen.dart';
import 'package:partyapp/login_pagenew.dart';
import 'package:partyapp/product.dart';
import 'package:partyapp/orderhistoy.dart';
import 'package:partyapp/product_model_services.dart';
import 'package:partyapp/profile_update.dart';
import 'package:partyapp/services_model/services_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'number_of_person.dart';

import 'ApiList.dart';
import 'change_password.dart';
import 'common/constant.dart';

class Services extends StatefulWidget {
  @override
  ServicesPage createState() => ServicesPage();
}

class ServicesPage extends State<Services> {
  AnimationController _controller;
  double screenHeight;
  double screenwidth;
  int counter = 0;
  bool checkValue = false;
  SharedPreferences sharedPreferences;
  var id;
  File _image;
  bool _isProgressBarShown = true;
  bool hasData = false;
  Map data;
  List listData;
  MediaQueryData queryData;
  var pic_list = ["images/bartender.jpg","images/beverage.jpg","images/butler.jpg","images/glassware.jpg"];

  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http.get(APIS.ProductDetails);
    var parsedJson = json.decode(response.body);
    data = json.decode(response.body);
    print ("Product List  :  "+data.toString());
    if(parsedJson["status"]=="1"){
      if (mounted) {
        setState(() {
          listData = data["data"];
          print(listData);
          // getCount();
          _isProgressBarShown = false;
        });
      }
      hasData = true;
    }


    /*Toast.show(""+listData.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();

  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<bool> _onWillPop() async {

  }

  Future<void> logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.clear();
    });
    //Navigator.of(context).pop();
    //Navigator.popUntil(context, ModalRoute.withName('/'));
    //Navigator.pop(context,true);// It worked for me instead of above line
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstScreen()),);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  Widget drawar() {
    return Container(
      color: AppTheme().color_red,
      width: MediaQuery.of(context).size.width / 1.3,
      child: new ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new Container(
                height: 150,
                //color: AppTheme().color_gray_light,
                child: new Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: new Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppTheme().color_white,
                                  border: Border.all(
                                      color: AppTheme().color_white, width: 5)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.asset(
                                  "images/categorys_image.jpg",
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 13),
                            child: new Container(
                              child: Center(
                                child: new Container(
                                  child: new Text(
                                    "User Name",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: new Container(
                              child: Center(
                                child: new Container(
                                  child: new Text(
                                    "user@user.com",
                                    style: TextStyle(
                                        color: AppTheme().color_white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 2,
              color: Colors.red[400],
            ),
          ),
          ListTile(
            title: Text("Home",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/home.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              getData();
              //Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(milliseconds:0), child: PaymentScreen()));
            },
          ),
          loginstatus == "guest"
              ? Container()
              : ListTile(
                  title: Text("Profile",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.person,
                        color: AppTheme().color_white,
                        size: 30,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.custom,
                            duration: Duration(milliseconds: 0),
                            child: ProfileUpdate()));
                  },
                ),
          ListTile(
            title: Text("Change Password",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/change_password.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: ChangePassword()));
            },
          ),
          ListTile(
            title: Text("Privacy",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/privacy.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: Privacy()));
            },
          ),
          ListTile(
            title: Text("FAQs",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/faqs.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: FaqScreen()));
            },
          ),
          ListTile(
            title: Text("T&C",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/tc.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: TermsCondition()));
            },
          ),
          loginstatus == "guest"
              ? Container()
              : ListTile(
                  title: Text("Order History",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Medium")),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "images/order_hist.ico",
                        width: 30,
                        height: 30,
                        color: AppTheme().color_white,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.custom,
                            duration: Duration(milliseconds: 0),
                            child: OrderHistoryScreen()));
                  },
                ),
          ListTile(
            title: Text("Contact Us",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/contact_us.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.custom,
                      duration: Duration(milliseconds: 0),
                      child: ContactUs()));
            },
          ),
          ListTile(
            title: Text("Logout",
                style: TextStyle(
                    color: AppTheme().color_white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Medium")),
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset(
                  "images/logout.png",
                  width: 30,
                  height: 30,
                )),
            onTap: () {
              Navigator.pop(context);
              logOut();
              //Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(milliseconds:0), child: PaymentScreen()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*  screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    queryData = MediaQuery.of(context);*/
    var size = MediaQuery.of(context).size;
    //print(size.height);
    final double itemHeight = (size.height - kToolbarHeight - 20) / 3.7;
    final double itemWidth = size.width / 2;
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        drawer: drawar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          // height:  queryData.size.height,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Expanded(
                        flex: 1,
                        child: new InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                Number_of_Person()), (Route<dynamic> route) => false);
                           // Navigator.of(context).pop();
                            //_scaffoldKey.currentState.openDrawer();
                          },
                          child: new Container(
                            height: 18,
                            child: new Image.asset(
                              "images/back_button.png",
                            ),
                          ),
                        )),
                    //

                    new Expanded(
                      flex: 4,
                      child: new Container(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                            "SERVICES",
                            style: TextStyle(
                                fontSize: 25,
                                color: AppTheme().color_white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 3,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: new InkWell(
                            onTap: () {
                              if(totalamount==0){
                                Toast.show("Please select any one product", context,
                                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                              }else{
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.custom,
                                        duration: Duration(milliseconds: 0),
                                        child: CheckOutScreen()
                                    )
                                );
                              }

                            },
                            child: new Container(
                                decoration: BoxDecoration(
                                    color: AppTheme().color_red,
                                    borderRadius: BorderRadius.circular(50)),
                                height: 35,
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppTheme().color_white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2),
                                  ),
                                )),
                          )),
                    ),
                    /*new Expanded(
                        child:Padding(
                          padding: const EdgeInsets.only(left:0,right: 0),
                          child: new Container(
                            margin: EdgeInsets.all(5),
                            height: 45 ,
                            decoration: BoxDecoration(
                                color: AppTheme().color_white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: new Image.asset("images/profile.png",),
                          ),
                        ))*/
                  ],
                ),
              ),
              /*   Padding(
                  padding: const EdgeInsets.only(top: 20,left: 15,right: 30),
                  child: new Row(
                    children: [
                      new Expanded(
                        flex: 9,
                        child: new Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: AppTheme().color_white,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child:  new Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: new Icon(Icons.search,size: 30,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: new Text("Search",style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 18,
                                    fontFamily: "Montserrat-SemiBold"
                                ),),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 30)),
                      new Expanded(
                        child: new Container(
                            height: 45,

                            child:Icon(Icons.add_shopping_cart,color: AppTheme().color_white,size: 30,)
                        ),
                      ),
                    ],
                  )
              ),*/

              /* Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "SERVICES",
                        style: TextStyle(
                            fontSize: 25,
                            color: AppTheme().color_white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),*/
              SERVICES_LIST==null
                  ? new Expanded(
                      child: new ListView(
                      shrinkWrap: true,
                      children: [itemLoading()],
                    ))
                  /*Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: new Center(
                              child: new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Center(
                                    child: Container(
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 16.0),
                                        child: Row(
                                          children: <Widget>[
                                            new CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                            ),
                                            Text(
                                              "    Loading...",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                      ),
                    )*/
                  : Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                              MediaQuery.of(context).size.height<700.0
                                  ?MediaQuery.of(context).size.height/780
                                  :MediaQuery.of(context).size.height/1000,
                             // childAspectRatio: (itemWidth / itemHeight/1.3),
                              mainAxisSpacing: 22),
                          itemCount:
                          SERVICES_LIST == null ? 0 : SERVICES_LIST.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new InkWell(
                                onTap: (){
                                  setState(() {
                                    titlename=SERVICES_LIST[index].productname;
                                    imageProduct= pic_list[index];
                                    descp=SERVICES_LIST[index].product_descr;
                                    if (person <=15) {
                                      price=SERVICES_LIST[index].rate15.toString();

                                    } else if (person <= 30) {
                                      price = SERVICES_LIST[index].rate30.toString();

                                    } else if (person <= 50) {
                                      price = SERVICES_LIST[index].rate50.toString();

                                    } else if (person <=  75) {
                                      price = SERVICES_LIST[index].rate75.toString();

                                    } else if (person <= 1000) {
                                      price = SERVICES_LIST[index].rate100.toString();

                                    }

                                    print("Title Name "+titlename);
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription()),);
                                },
                                child:Counter(
                                  index: index,
                                  listData: SERVICES_LIST,
                                )
                              );
                          })
                    ),
              SizedBox(
                height: 20,
              ),
              SERVICES_LIST==null
                  ?itemtotalLoading():
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: InkWell(
                  onTap: () {
                    if(totalamount==0){
                      Toast.show("Please select any one product", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }else{
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.custom,
                              duration: Duration(milliseconds: 0),
                              child: CheckOutScreen()
                          )
                      );
                    }

                  },
                  child: new Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: AppTheme().color_red,
                        borderRadius: BorderRadius.circular(10)),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "Total Amount",
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontSize: 18,
                              fontFamily: "Montserrat"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        new Text(
                          ":",
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontSize: 18,
                              fontFamily: "Montserrat"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        new Text(
                          totalamount.toString(),
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontSize: 18,
                              fontFamily: "Montserrat"),
                        )
                        /*new Expanded(child: new Text("Total")),
                        new Expanded(child: new Text(":")),
                        new Expanded(child: new Text(""))*/
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20))
            ],
          ),
        ),
      ),
    );
  }

  Widget itemLoading() {
    return new Padding(
        padding: new EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
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
                )
              ],
            )));
  }

  Widget itemtotalLoading() {
    return new Padding(
        padding: new EdgeInsets.only(top: 0.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: new Column(
              children: [
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 45.0,
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

class Counter extends StatefulWidget {
  final int index;
  final List<ServicesModel_list>listData;

  Counter({this.index, this.listData});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int services = 1;
  int producttotal = 0;
  int total = 0;
  int price;
  int person_mult_price;
  ProductServicesModel productModel;
  var pic_list = ["images/bartender.jpg","images/beverage.jpg","images/butler.jpg","images/glassware.jpg"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mult_rate();
    services = 1;
    product.clear();
    totalrates();
  }
  void totalrates(){
    if (person <= 15) {
      for (int i = 0; i < widget.listData.length; i++) {
        if(widget.listData[i].id==1){
          producttotal += widget.listData[i].rate15;
        }
        if(widget.listData[i].id==2){
          producttotal += widget.listData[i].rate15;
        }
      }
      totalamount = producttotal;
      if(widget.listData[widget.index].id==3){

        totalamount_bev=totalamount+person_mult_price;
        print("totalamount_bev :  "+totalamount_bev.toString());
      }
      if(widget.listData[widget.index].id==4){
        totalamount_bev=totalamount_bev+person_mult_price;
        totalamount=totalamount_bev;
        print("totalamountglas :  "+totalamount_bev.toString());
      }
      for(int i=0;i<widget.listData.length;i++){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[i].id.toString();
        productModel.total=totalamount;
        if(widget.listData[i].productname=="Beverage"){
          productModel.qyt=person;
        }else if(widget.listData[i].productname=="Glassware"){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e.toJson()).toList());
      print(jsons);
    }
    else if (person <= 30) {
      for (int i = 0; i < widget.listData.length; i++) {
        if(widget.listData[i].id==1){
          producttotal += widget.listData[i].rate30;
        }
        if(widget.listData[i].id==2){
          producttotal += widget.listData[i].rate30;
        }
      }
      totalamount = producttotal;
      if(widget.listData[widget.index].id==3){

        totalamount_bev=totalamount+person_mult_price;
        print("totalamount_bev :  "+totalamount_bev.toString());
      }
      if(widget.listData[widget.index].id==4){
        totalamount_bev=totalamount_bev+person_mult_price;
        totalamount=totalamount_bev;
        print("totalamountglas :  "+totalamount_bev.toString());
      }
      for(int i=0;i<widget.listData.length;i++){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[i].id.toString();
        productModel.total=totalamount;
        if(widget.listData[widget.index].id==3&& widget.listData[widget.index].id==4){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e.toJson()).toList());
      print(jsons);

    }
    else if (person <= 50) {
      for (int i = 0; i < widget.listData.length; i++) {
        if(widget.listData[i].id==1){
          producttotal += widget.listData[i].rate50;
        }
        if(widget.listData[i].id==2){
          producttotal += widget.listData[i].rate50;
        }
      }
      totalamount = producttotal;
      if(widget.listData[widget.index].id==3){

        totalamount_bev=totalamount+person_mult_price;
        print("totalamount_bev :  "+totalamount_bev.toString());
      }
      if(widget.listData[widget.index].id==4){
        totalamount_bev=totalamount_bev+person_mult_price;
        totalamount=totalamount_bev;
        print("totalamountglas :  "+totalamount_bev.toString());
      }
      for(int i=0;i<widget.listData.length;i++){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[i].id.toString();
        productModel.total=totalamount;
        if(widget.listData[widget.index].id==3&& widget.listData[widget.index].id==4){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e.toJson()).toList());
      print(jsons);
    }
    else if (person <= 75) {
      for (int i = 0; i < widget.listData.length; i++) {
        if(widget.listData[i].id==1){
          producttotal += widget.listData[i].rate75;
        }
        if(widget.listData[i].id==2){
          producttotal += widget.listData[i].rate75;
        }
      }
      totalamount = producttotal;
      if(widget.listData[widget.index].id==3){

        totalamount_bev=totalamount+person_mult_price;
        print("totalamount_bev :  "+totalamount_bev.toString());
      }
      if(widget.listData[widget.index].id==4){
        totalamount_bev=totalamount_bev+person_mult_price;
        totalamount=totalamount_bev;
        print("totalamountglas :  "+totalamount_bev.toString());
      }
      for(int i=0;i<widget.listData.length;i++){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[i].id.toString();
        productModel.total=totalamount;
        if(widget.listData[widget.index].id==3&& widget.listData[widget.index].id==4){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e.toJson()).toList());
      print(jsons);
    }
    else if (person <= 1000) {
      for (int i = 0; i < widget.listData.length; i++) {
        if(widget.listData[i].id==1){
          producttotal += widget.listData[i].rate100;
        }
        if(widget.listData[i].id==2){
          producttotal += widget.listData[i].rate100;
        }
      }
      totalamount = producttotal;
      if(widget.listData[widget.index].id==3){

        totalamount_bev=totalamount+person_mult_price;
        print("totalamount_bev :  "+totalamount_bev.toString());
      }
      if(widget.listData[widget.index].id==4){
        totalamount_bev=totalamount_bev+person_mult_price;
        totalamount=totalamount_bev;
        print("totalamountglas :  "+totalamount_bev.toString());
      }
      for(int i=0;i<widget.listData.length;i++){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[i].id.toString();
        productModel.total=totalamount;
        if(widget.listData[widget.index].id==3&& widget.listData[widget.index].id==4){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e.toJson()).toList());
      print(jsons);
    }
  }
  void addItemToList(){
    setState(() {
      if(product.isEmpty){
        productModel = new ProductServicesModel(
          "",
          "",
          0,
        );
        productModel.prod_id=widget.listData[widget.index].id.toString();
        if(person<=15){
          productModel.total=price;
        }else if(person<=30){
          productModel.total=price;
        }else if(person<=50){
          productModel.total=price;
        }else if(person<=75){
          productModel.total=price;
        }else if(person<=1000){
          productModel.total=price;
        }
        if(widget.listData[widget.index].id==3){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        if(widget.listData[widget.index].id==4){
          productModel.qyt=person;
        }else{
          productModel.qyt=services;
        }
        product.add(productModel);
      }
      else{
        if(product[widget.index].prod_id==widget.listData[widget.index].id.toString()){
          if(person<=15){
            productModel.total=price;
          }else if(person<=30){
            productModel.total=price;
          }else if(person<=50){
            productModel.total=price;
          }else if(person<=75){
            productModel.total=price;
          }else if(person<=1000){
            productModel.total=price;
          }
          if(widget.listData[widget.index].id==3&& widget.listData[widget.index].id==4){
            productModel.qyt=person;
          }else{
            productModel.qyt=services;
          }
         for(int i=0;i<product.length;i++){
           product[i].total=totalamount;
         }
          product[widget.index].qyt=productModel.qyt;

        }
        /*else{
          productModel = new ProductServicesModel(
            "",
            "",

            0,
          );
          productModel.prod_id=widget.listData[widget.index]["id"].toString();
          if(person<=15){
            productModel.total=price;
          }else if(person<=30){
            productModel.total=price;
          }else if(person<=50){
            productModel.total=price;
          }else if(person<=75){
            productModel.total=price;
          }else if(person<=1000){
            productModel.total=price;
          }
          productModel.qyt=services;
          product[widget.index].total=totalamount;
          product[widget.index].qyt=productModel.qyt;
        }*/
        jsons = jsonEncode(product.map((e) => e.toJson()).toList());
        print(jsons);
      }
    });

  }
  void gls_rate(){
    if(checkedValue_2==true){
      if (person <= 15) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+totalamount.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 30) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }


      }
      else if (person <= 50) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 75) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 1000) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }

    }

    else if(checkedValue_2==false){
      if (person <= 15) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+totalamount.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 30) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }


      }
      else if (person <= 50) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 75) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 1000) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
    }
  }
  void bev_rate(){
    if(checkedValue_1==true){
      if (person <= 15) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+totalamount.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 30) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }


      }
      else if (person <= 50) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 75) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 1000) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount - person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }

    }

    else if(checkedValue_1==false){
      if (person <= 15) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+totalamount.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 30) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }


      }
      else if (person <= 50) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 75) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
      else if (person <= 1000) {
        if(widget.listData[widget.index].id==3){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
        else if(widget.listData[widget.index].id==4){
          totalamount = totalamount + person_mult_price;
          print("person_mult_price:     "+person_mult_price.toString());
        }
      }
    }

  }
  void mult_rate(){
    if (person <= 15) {
      if(widget.listData[widget.index].id==3){
        person_mult_price = person * widget.listData[widget.index].rate15;
        print("person_mult_price:     "+totalamount.toString());
      }
      else if(widget.listData[widget.index].id==4){
        person_mult_price = person * widget.listData[widget.index].rate15;
        print("person_mult_price:     "+person_mult_price.toString());
      }
    }
    if (person <= 30) {
      if(widget.listData[widget.index].id==3){
        person_mult_price = person * widget.listData[widget.index].rate30;
        print("person_mult_price:     "+person_mult_price.toString());
      }
      else if(widget.listData[widget.index].id==4){
        person_mult_price = person * widget.listData[widget.index].rate30;
        print("person_mult_price:     "+person_mult_price.toString());
      }


    }
    if (person <= 50) {
      if(widget.listData[widget.index].id==3){
        person_mult_price = person * widget.listData[widget.index].rate50;
        print("person_mult_price:     "+person_mult_price.toString());
      }
      else if(widget.listData[widget.index].id==4){
        person_mult_price = person * widget.listData[widget.index].rate50;
        print("person_mult_price:     "+person_mult_price.toString());
      }
    }
    if (person <= 75) {
      if(widget.listData[widget.index].id==3){
        person_mult_price = person * widget.listData[widget.index].rate75;
        print("person_mult_price:     "+person_mult_price.toString());
      }
      else if(widget.listData[widget.index].id==4){
        person_mult_price = person * widget.listData[widget.index].rate75;
        print("person_mult_price:     "+person_mult_price.toString());
      }
    }
    if (person <= 1000) {
      if(widget.listData[widget.index].id==3){
        person_mult_price = person * widget.listData[widget.index].rate100;
        print("person_mult_price:     "+person_mult_price.toString());
      }
      else if(widget.listData[widget.index].id==4){
        person_mult_price = person * widget.listData[widget.index].rate100;
        print("person_mult_price:     "+person_mult_price.toString());
      }
    }
  }
  void add_services() {
    setState(() {
      services++;
      if (person <= 15) {
        price = services * widget.listData[widget.index].rate15;
        totalamount = totalamount + widget.listData[widget.index].rate15;
        producttotal = totalamount;
        print("total  add : " + totalamount.toString());
        addItemToList();
      }
      else if (person <= 30) {
        price = services * widget.listData[widget.index].rate30;
        totalamount = totalamount + widget.listData[widget.index].rate30;
        producttotal = totalamount;
        print("total  add : " + totalamount.toString());
        addItemToList();
      }
      else if (person <= 50) {
        price = services * widget.listData[widget.index].rate50;
        totalamount = totalamount + widget.listData[widget.index].rate50;
        producttotal = totalamount;
        print("total  add : " + totalamount.toString());
        addItemToList();
      }
      else if (person <= 75) {
        price = services * widget.listData[widget.index].rate75;
        totalamount = totalamount + widget.listData[widget.index].rate75;
        producttotal = totalamount;
        print("total  add : " + totalamount.toString());
        addItemToList();
      }
      else if (person <= 1000) {
        price = services * widget.listData[widget.index].rate100;
        totalamount = totalamount + widget.listData[widget.index].rate100;
        producttotal = totalamount;
        print("total  add : " + totalamount.toString());
        addItemToList();
      }
    });
  }
  void miuns_services() {
    setState(() {
      services--;
      if (person <=15) {
        price = services * widget.listData[widget.index].rate15;
        totalamount = totalamount - widget.listData[widget.index].rate15;
        producttotal = totalamount;
        print("total minus : " + totalamount.toString());
        addItemToList();
      } else if (person <= 30) {
        price = services * widget.listData[widget.index].rate30;
        totalamount = totalamount - widget.listData[widget.index].rate30;
        producttotal = totalamount;
        print("total minus : " + totalamount.toString());
        addItemToList();
      } else if (person <= 50) {
        price = services * widget.listData[widget.index].rate50;
        totalamount = totalamount - widget.listData[widget.index].rate50;
        producttotal = totalamount;
        print("total minus : " + totalamount.toString());
        addItemToList();
      } else if (person <=  75) {
        price = services * widget.listData[widget.index].rate75;
        totalamount = totalamount - widget.listData[widget.index].rate75;
        producttotal = totalamount;
        print("total minus : " + totalamount.toString());
        addItemToList();
      } else if (person <= 1000) {
        price = services * widget.listData[widget.index].rate100;
        totalamount = totalamount - widget.listData[widget.index].rate100;
        producttotal = totalamount;
        print("total minus : " + totalamount.toString());
        addItemToList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 11, right: 11,),
      child:new Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              bottomRight: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              topLeft: const Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 3, offset: Offset(0, 5))
            ]),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                /*child: Image.network("http://partyapp.v2infotech.net/resources/" +
                                              listData[index]["C_Pic"],fit: BoxFit.cover,
                                          ),*/
                child: Image.asset(
                  pic_list[widget.index],
                  fit: BoxFit.cover,
                ),
              ),
            ),

           new Row(
             children: [
               Padding(
                 padding:  EdgeInsets.only(top: 10,left: 10),
                 child: new Container(
                   child: Text(
                     '${widget.listData[widget.index].productname.toUpperCase()}',
                     /*"${listData[0][index]["C_Name"]}".toUpperCase(),*/
                     textAlign: TextAlign.left,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                         color: AppTheme().color_black,
                         fontFamily: 'Montserrat',
                         fontSize: 15,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
               widget.listData[widget.index].productname=="Beverage"?Padding(
                 padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/9,top: 5),
                 child: SizedBox(
                   height: 20.0,
                   width: 20.0,
                   child:Checkbox(
                       activeColor: AppTheme().color_black,
                     checkColor: AppTheme().color_white,
                     value: checkedValue_1,

                     onChanged: (value){
                       bev_rate();
                       setState(() {
                        checkedValue_1=value;
                       });
                       print("checkedValue_1:     "+checkedValue_1.toString());
                     }
                 ),)
               ):widget.listData[widget.index].productname=="Glassware"?
               Padding(
                 padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/13,top: 5),
                 child: SizedBox(
                     height: 20.0,
                     width: 20.0,
                     child:Checkbox(
                         activeColor: AppTheme().color_black,
                         checkColor: AppTheme().color_white,
                     value: checkedValue_2,
                     onChanged: (value){
                         gls_rate();
                         setState(() {
                         checkedValue_2=value;
                       });
                     }
                 )),
               ):new Container()

             ],
           ),
            Padding(
              padding:  EdgeInsets.only(top:10, left: 10),
              child: new Row(
                // alignment: WrapAlignment.end,
                // crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Expanded(
                    child: new Container(
                        child: new Wrap(
                          children: [
                            person <= 15
                                ? new Text(
                              'Price '+ '₹ ' +
                              (widget.listData[widget.index].rate15 )
                                      .toString(),
                              textAlign: TextAlign.left,
                              //overflow:TextOverflow.ellipsis ,
                              style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              )
                                : person <= 30
                                ? new Text(
                              'Price '+'₹' +
                                  (widget.listData[widget.index].rate30 )
                                      .toString(),
                              textAlign: TextAlign.left,
                              //overflow:TextOverflow.ellipsis ,
                              style: TextStyle(
                                color: AppTheme().color_black,
                                fontFamily: 'Montserrat-SemiBold',
                                fontSize: 12,
                              ),
                            )
                                : person <= 50
                                ? new Text(
                              'Price '+'₹' +
                                  (widget.listData[widget.index].rate50 )
                                      .toString(),
                              textAlign: TextAlign.left,
                              //overflow:TextOverflow.ellipsis ,
                              style: TextStyle(
                                color: AppTheme().color_black,
                                fontFamily: 'Montserrat-SemiBold',
                                fontSize: 12,
                              ),
                            )
                                : person <= 75
                                ? new Text(
                              'Price '+'₹' +
                                  (widget.listData[widget.index].rate75 * services)
                                      .toString(),
                              textAlign: TextAlign.left,
                              //overflow:TextOverflow.ellipsis ,
                              style: TextStyle(
                                color: AppTheme().color_black,
                                fontFamily: 'Montserrat-SemiBold',
                                fontSize: 12,
                              ),
                            )
                                : person <= 1000
                                ? new Text(
                              'Price '+'₹' +
                                  (widget.listData[widget.index].rate100 * services)
                                      .toString(),
                              textAlign: TextAlign.left,
                              //overflow:TextOverflow.ellipsis ,
                              style: TextStyle(
                                color: AppTheme().color_black,
                                fontFamily:
                                'Montserrat-SemiBold',
                                fontSize: 12,
                              ),
                            )
                                : "",
                          ],
                        ),

                    ),
                  ),

                  Expanded(
                      child: new Container(
                          child:widget.listData[widget.index].productname=="Beverage"
                              ?new Row(
                            children: [
                               services == 0
                                  ? new Icon(Icons.remove_circle,
                                  color: AppTheme().color_black)
                                  : new InkWell(
                                onTap: () {
                                 // miuns_services();
                                },
                                child: new Icon(Icons.remove_circle,
                                    color: AppTheme().color_white),
                              ),
                              person <= 15
                                  ? new Text(
                                person.toString()+'x'+
                                    (widget.listData[widget.index].rate15 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                    color: AppTheme().color_black,
                                    fontFamily: 'Montserrat-SemiBold',
                                    fontSize: 15,
                                    ),
                              )
                                  : person <= 30
                                  ? new Text(
                                person.toString()+'x'+
                                    (widget.listData[widget.index].rate30 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 50
                                  ? new Text(
                                person.toString()+'x'+
                                    ( widget.listData[widget.index]
                                        .rate50 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 75
                                  ? new Text(
                                person.toString()+'x'+
                                    ( widget.listData[widget.index]
                                        .rate75 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 1000
                                  ? new Text(
                                person.toString()+'x'+
                                    (widget
                                        .listData[widget.index].rate100 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : "",
                              Padding(padding: EdgeInsets.only(left: 2)),
                              /*new InkWell(
                                onTap: () {
                                  add_services();
                                },
                                child: new Icon(Icons.add_circle_sharp,
                                    color: AppTheme().color_black),
                              )*/
                            ],
                          )
                              :widget.listData[widget.index].productname=="Glassware"
                              ?new Row(
                            children: [
                              services == 0
                                  ? new Icon(Icons.remove_circle,
                                  color: AppTheme().color_black)
                                  : new InkWell(
                                onTap: () {
                                  //miuns_services();
                                },
                                child: new Icon(Icons.remove_circle,
                                    color: AppTheme().color_white),
                              ),
                              Padding(padding: EdgeInsets.only(left: 2)),
                              person <= 15
                                  ? new Text(
                                person.toString()+'x' +
                               (widget.listData[widget.index].rate15 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                    color: AppTheme().color_black,
                                    fontFamily: 'Montserrat-SemiBold',
                                    fontSize: 15,
                                    ),
                              )
                                  : person <= 30
                                  ? new Text(
                                person.toString()+'x' +
                             (widget.listData[widget.index].rate30 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 50
                                  ? new Text(
                                person.toString()+'x' +
                                    (widget.listData[widget.index].rate50 )
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 75
                                  ? new Text(
                                person.toString()+'x'+
                                    (widget.listData[widget.index].rate75)
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : person <= 1000
                                  ? new Text(
                                person.toString()+'x' +
                                    (widget.listData[widget.index].rate100)
                                        .toString(),
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().color_black,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 15,
                                ),
                              )
                                  : "",
                              Padding(padding: EdgeInsets.only(left: 2)),
                              /*new InkWell(
                                onTap: () {
                                  add_services();
                                },
                                child: new Icon(Icons.add_circle_sharp,
                                    color: AppTheme().color_black),
                              )*/
                            ],
                          )
                              :new Row(
                            children: [
                              services == 0
                                  ? new Icon(Icons.remove_circle,
                                  color: AppTheme().color_black)
                                  : new InkWell(
                                onTap: () {
                                  miuns_services();
                                },
                                child: new Icon(Icons.remove_circle,
                                    color: AppTheme().color_black),
                              ),
                              Padding(padding: EdgeInsets.only(left: 2)),
                              new Text(
                                services == 1 ? "1" : services.toString(),
                                style: TextStyle(color: AppTheme().color_black),
                              ),
                              Padding(padding: EdgeInsets.only(left: 2)),
                              new InkWell(
                                onTap: () {
                                  add_services();
                                },
                                child: new Icon(Icons.add_circle_sharp,
                                    color: AppTheme().color_black),
                              )
                            ],
                          )
                      )
                  )
                ],
              ),
            ),
            Padding(
                padding:  EdgeInsets.only(top: 10, left: 10, right: 10),
                child:new Container(
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppTheme().color_black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: person <= 15
                            ? new Text(
                          widget.listData[widget.index].productname=="Glassware"?'₹' +person_mult_price
                              .toString():widget.listData[widget.index].productname=="Beverage"?'₹' +person_mult_price
                              .toString():'₹' +(widget.listData[widget.index].rate100 * services).toString(),
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person <= 30
                            ? new Text(
                          widget.listData[widget.index].productname=="Glassware"?'₹' +person_mult_price
                              .toString():widget.listData[widget.index].productname=="Beverage"?'₹' +person_mult_price
                              .toString():'₹' +(widget.listData[widget.index].rate100 * services).toString(),
                          style: TextStyle(
                              color: AppTheme().color_white,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person <= 50
                            ? new Text(
                          widget.listData[widget.index].productname=="Glassware"?'₹' +person_mult_price
                              .toString():widget.listData[widget.index].productname=="Beverage"?'₹' +person_mult_price
                              .toString():'₹' +(widget.listData[widget.index].rate100 * services).toString(),
                          style: TextStyle(
                              color: AppTheme()
                                  .color_white,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person <= 75
                            ? new Text(
                          widget.listData[widget.index].productname=="Glassware"?'₹' +person_mult_price
                              .toString():widget.listData[widget.index].productname=="Beverage"?'₹' +person_mult_price
                              .toString():'₹' +(widget.listData[widget.index].rate100 * services) .toString(),
                          style: TextStyle(
                              color: AppTheme()
                                  .color_white,
                              fontFamily:
                              "Montserrat",
                              fontSize: 15),
                        )
                            : person <= 1000
                            ? new Text(

                              widget.listData[widget.index].productname=="Glassware"?'₹' +person_mult_price
                              .toString():widget.listData[widget.index].productname=="Beverage"?'₹' +person_mult_price
                              .toString():'₹' +(widget.listData[widget.index].rate100 * services).toString(),
                              style: TextStyle(
                              color: AppTheme()
                                  .color_white,
                              fontFamily:
                              "Montserrat",
                              fontSize: 15),
                        )
                            : ""
                           ))
            ),
          ],
        ),
      ),
    );
  }
}
