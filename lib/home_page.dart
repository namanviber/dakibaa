import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ApiList.dart';
import 'Cart.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'EditProfile.dart';
import 'Services.dart';
class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  int _currentIndex = 0;
  int counter = 0;
  SharedPreferences sharedPreferences;
  var id;
  bool checkValue = false;
  Map<String, dynamic> value;
  final List<Widget> _children = [
    Services(),
    Cart(),
    PartySetting(),
    EditProfilePage()
  ];
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getCredential();
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          id = sharedPreferences.getString("id");
          // pid=sharedPreferences.getString("pid");

          // print(pid);
        } else {
          id.clear();

        }
      } else {
        checkValue = false;
      }
    });
  }
  Future<Map<String, dynamic>> getCount() async {
    final response = await http.post(APIS.getCartCount,
        headers: {'Accept': 'application/json'},
        body: {"userid": id.toString()});
    var parsedJson = json.decode(response.body);
    // value = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      print(parsedJson.toString());
      counter=parsedJson['data'];
      // pr.dismiss();
      /* Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/

    } if(parsedJson['status'] == "0") {
      //pr.dismiss();
      /*  Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      _ackAlert(context);*/

    }
    return parsedJson;
  }
  @override
  Widget build(BuildContext context) {
  //  getCount();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _children[_currentIndex],
       /* bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.red[800],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          elevation: 15.0,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          // this will be set when a new tab is tapped
          items: [

            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage("images/order.png"),
                  height: 30.0,
                ),
                title: Text("")),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage("images/cart.png"),
                  height: 30.0,
                ),

           *//* SizedBox(
              height: 30.0,
              width: 30,
              child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: Image(
                        image: AssetImage("images/cart.png"),
                        height: 30.0,
                      ),
                ),
                counter != 0 ? new Positioned(
                  right: 0,
                  top: 0,
                  child: new Container(
                    padding: EdgeInsets.all(0),
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    child: Center(
                      child: Text(
                        '$counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ) : new Container()

              ],
                  ),
            ),*//*
                title: Text("")),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage("images/setting.png"),
                  height: 30.0,
                ),
                title: Text("")),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage("images/user.png"),
                  height: 30.0,
                ),
                title: Text("")),
          ],
        ),*/

        // body: ListViewScreen(),
      ),
    );
  }



  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
