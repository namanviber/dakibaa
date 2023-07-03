import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/CartModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'ApiList.dart';
import 'checkout_screen.dart';
import 'login_pagenew.dart';


class Cart extends StatefulWidget {
  @override
  CartPage createState() => CartPage();
}

class CartPage extends State<Cart> {
  bool? checkValue;
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  File? _image;
  late ProgressDialog pr;
  Map<String, dynamic>? value,value1,value2;
  List listData=[];
  late var price;
  var total=0;
  var p;
  late SharedPreferences sharedPreferences;
  List <CartModel> cartModel= [];
  var id,productId;
  int? count;
  var sum = 0;
  int? sumP;
  var given_list = [];
  String? id1;
  List<String> list=[] ;
  String id_list="";

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  var message;
  Future<Map<String, dynamic>> getData(var uid) async {
    /*  pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();*/
    // print(token);
    final response = await http.post(APIS.getCartList,
        headers: {'Accept': 'application/json'},
        body: {"userid": uid.toString()});
    var parsedJson = json.decode(response.body);
    print(response.body);
    value = json.decode(response.body);

    if (parsedJson['status'] == "1") {
      message=value!["message"];
      // pr.dismiss();
      if(mounted) {
        setState(() {
          for (int i = 0; i < value!["data"].length; i++) {
            CartModel _productModel = new CartModel(
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                0,
                "");
            print(value!["data"][i]["Id"].toString());
            id1 = value!["data"][i]["cid"].toString();
            list.add(id1.toString());
            _productModel.Id = value!["data"][i]["productid"].toString();
            _productModel.cid = value!["data"][i]["cid"].toString();
            // _productModel.C_Id = value["data"][i]["C_Id"];
            _productModel.Productname = value!["data"][i]["Productname"];
            if (value!["data"][i].containsKey("productImages")) {
              _productModel.productImages =
              value!["data"][i]["productImages"][0]["Imagename"];
            }
            _productModel.Description = value!["data"][i]["Description"];
            if (value!["data"][i].containsKey("productPrice")) {
              _productModel.productPrice =
              value!["data"][i]["productPrice"][0]["Price"];
            }
            _productModel.unitId = value!["data"][i]["unitid"].toString();

            _productModel.count = value!["data"][i]["quantity"];
            _productModel.price = value!["data"][i]["amount"].toString();
            cartModel.add(_productModel);
            print(_productModel);
            print(_productModel.Id);
            sumP = int.parse(cartModel[i].price);
            given_list.add(sumP);
            sum = given_list.fold(0, (previous, current) => previous + current as int);
            print("Sum wqww: ${sum}");
            print("Sumsdasda : ${given_list}");
          }
        });
      }
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    } else {
      // pr.dismiss();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      _ackAlert(context);
    }
    return parsedJson;
  }
  Future<Map<String, dynamic>> getCountData(String productId,int index, price) async {

    print(id);
    print(count);
    print(productId);
    /*   pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();*/

    final response = await http.post(APIS.addPackageCount,
        headers: {'Accept': 'application/json'},
        body: {
          "productid": productId.toString(),
          "unitid":cartModel[index].unitId.toString(),
          "amount":price.toString(),
          "quantity": cartModel[index].count.toString(),
          "userid": id
    });

    print({"productid": productId.toString(),
      "unitid":cartModel[index].unitId.toString(),
      "amount":price.toString(),
      "quantity": cartModel[index].count.toString(),
      "userid": id});
    var parsedJson = json.decode(response.body);
    value1 = json.decode(response.body);
    /*  print("Status = " + parsedJson['status']);*/
    if (parsedJson['status'] == "1") {
      //  pr.dismiss();

      setState(() {
        cartModel.clear();
        getData(id);
      });
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    } else {
      //  pr.dismiss();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    }
    return parsedJson;
  }

  Future<Map<String, dynamic>> removeProductCart(String cid) async {

       pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();

    final response = await http.post(APIS.removeProductCart,
        headers: {'Accept': 'application/json'},
        body: {"ID": cid.toString()});
    var parsedJson = json.decode(response.body);
    value2 = json.decode(response.body);
    /*  print("Status = " + parsedJson['status']);*/
    if (parsedJson['status'] == "1") {
        pr.hide();

        setState(() {
          cartModel.clear();
          given_list.clear();
          getData(id);
        });

        Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    } else {
        pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

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
          price = sharedPreferences.getString("price")??'0';
          getData(id);
        } else {
          id.clear();
          price.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
  _removeProduct(int? count,var productId, int index) {
    setState(() {
      if (cartModel[index].count! > 0) {
        cartModel[index].count! - 1;
        cartModel[index].price = int.parse(cartModel[index].price.toString()) - p;
        getCountData(productId.toString(), index, cartModel[index].price);

      }
    });

  }

  _addProduct(int? count, var productId,int index) {
    setState(() {
      cartModel[index].count! + 1;
      cartModel[index].price=(p*cartModel[index].count).toString();
      print(cartModel[index].price.toString());
      getCountData(productId.toString(),index, cartModel[index].price);

    });

  }
  onChanged(bool value,var price) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue!);
      sharedPreferences.setString("price",price.toString());
      sharedPreferences.commit();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getCredential();

  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(220, 84, 85, 0.8),
              Color.fromRGBO(140, 53, 52, 1)
            ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
          child: Stack(
            children: <Widget>[
              profile_Page(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile_Page(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                          padding: EdgeInsets.only(
                            left: 0.0,
                            right: 0.0,
                            top: 20.0,
                          ),
                          child: Center(
                            child: Container(
                              child: Image.asset(
                                "images/shopping_cart.png",
                                fit: BoxFit.fill,
                                height: 90,
                                width: 90,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "CART",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 4),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 260,

                  child:  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,

                      itemCount: cartModel == null ? 0 : cartModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Stack(
                          children: <Widget>[ Container(
                                  child:  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(18))),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
                                          height: 140,
                                          width: 100,
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18),bottomLeft: Radius.circular(18)),
                                              image:  DecorationImage(
                                                image: NetworkImage(
                                                    "http://adminparty.v2infotech.net/images/productimages/" +
                                                        cartModel[index].productImages),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(right: 25, top: 4,),
                                                      child: Text(
                                                        "${cartModel[index].Productname}",
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontFamily: 'Roboto',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            letterSpacing: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          child: Text(
                                                            "Description:- ",
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontFamily: 'Roboto',
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                letterSpacing: 1.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Text(
                                                            "${cartModel[index].Description}",
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: 'Roboto',
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Center(
                                                        child: Container(
                                                          height: 30,
                                                          width: 80,


                                                          child: Center(
                                                            child: Text(
                                                              "Rs ${cartModel[index].price}",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily: 'Roboto',
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                                            color: Colors.red,),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: <Widget>[

                                                            GestureDetector(
                                                              onTap:()
                                                              {

                                                                setState(() {
                                                                  count=cartModel[index].count;
                                                                  p=cartModel[index].productPrice;
                                                                  productId=cartModel[index].Id.toString();
                                                                  given_list.clear();
                                                                });
                                                                _removeProduct(count,productId,index);
                                                              },
                                                              child: Container(
                                                                child: Icon(
                                                                  Icons.remove_circle ,
                                                                  size: 24,
                                                                  color: Colors.redAccent,
                                                                ),
                                                              ),
                                                            ),

                                                            Container(
                                                              padding: const EdgeInsets.only(
                                                                  bottom: 2, right: 8, left: 8),
                                                              child: Text(
                                                                "${cartModel[index].count}",
                                                                style:
                                                                TextStyle(
                                                                  color: Colors.redAccent,
                                                                  fontFamily: 'Roboto',
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap:()
                                                              {
                                                                setState(() {
                                                                  count=cartModel[index].count;
                                                                  p=cartModel[index].productPrice;
                                                                  productId=cartModel[index].Id.toString();
                                                                  given_list.clear();
                                                                });
                                                                _addProduct(count,productId.toString(),index);

                                                              },
                                                              child: Container(
                                                                child: Icon(
                                                                  Icons.add_circle,
                                                                  size: 24,
                                                                  color: Colors.redAccent,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                        Container(
                                                  child: Text(
                                                    " BASE PRICE : Rs ${cartModel[index].productPrice}",
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  removeProductCart(cartModel[index].cid.toString());
                                },
                                icon: Icon(Icons.cancel),
                                color: Colors.black,
                              ),
                            ),

                          ],
                              ),
                              SizedBox(
                                height: 8,
                              ),

                            ],
                          ),
                        );

                      }
                  ),
                ),

              SizedBox(
                height: 18,
              ),
              Container(
                child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          bottomRight: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                          bottomLeft: const Radius.circular(25.0),
                          topLeft: const Radius.circular(25.0),
                        )),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration.collapsed(
                            hintText: "ADD MORE REQUIREMENTS",
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: 140,
                      height: 50,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Container(

                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                alignment: Alignment.center,
                                child: Container(

                                  child: Text(
                                    "TOTAL SUM",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        letterSpacing: 2.0),
                                  ),
                                ),
                              ),
                              Container(

                                alignment: Alignment.center,
                                child:message=="Cart is blank"? Text(
                                  "0 RS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 2.0),
                                ):Text(
                                  sum.toString()+" RS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 2.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red,),
                    ),
                    Container(
                      width: 140,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(40, 10, 10, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          if(message=="Cart is blank") {
                            Toast.show("" + "Please add some items in the cart", context,
                                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                          }
                          else{
                            for(int i=0;i<list.length;i++){
                              if(i==(list.length-1)){
                                id_list=id_list+list[i];
                              }
                              else{
                                id_list=id_list+list[i]+",";
                              }

                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  CheckOutScreen(price: sum.toString(),id_list:id_list)),
                            );

                          }
                        },
                        child: Center(
                          child: Container(
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "CHECK OUT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log In First'),
          content: const Text('Please login first to check the Profile!!!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }


}
