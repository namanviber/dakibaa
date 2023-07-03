import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/ProductModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ApiList.dart';
import 'ProductDetail.dart';
import 'login_pagenew.dart';

class ProductScreen extends StatefulWidget {
  Map? data;
  ProductScreen({this.data});

  @override
  Product createState() => Product(data: data);
}

class Product extends State<ProductScreen> {
  Map? data;
 // var counter=0;
  //var price=0;
  int? p,sumP;
  Product({this.data});
  late SharedPreferences sharedPreferences;
  bool checkValue = false;
  var id;
  String? productId;
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  List <ProductModel> productModel= [];
  File? _image;
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  Map<String, dynamic>? value1;
  List? listData;
  var sum = 0;
  var given_list = [];

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  Future<Map<String, dynamic>> getData() async {
      //print(data['Id'].toString());
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString("id");
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    // print(token);
    final response = await http.post(APIS.getProduct,
        headers: {'Accept': 'application/json'},
        body: {
      "brandid": data!['Id'].toString(),
          "userid":id.toString()
    });
    var parsedJson = json.decode(response.body);
    value = json.decode(response.body);

  /*  print("Status = " + parsedJson['status']);*/
    if (parsedJson['status'] == "1") {
      pr.hide();
      if(mounted) {
        setState(() {
          for (int i = 0; i < value!["data"].length; i++) {
            ProductModel _productModel = new ProductModel(
                "",
                "",
                "",
                "",
                "",
                "",
                0,
                0,
                "");
            print(value!["data"][i]["Id"].toString());
            _productModel.Id = value!["data"][i]["Id"].toString();
             _productModel.IsActive = value!["data"][i]["IsActive"];
            _productModel.Productname = value!["data"][i]["Productname"];
            if (value!["data"][i].containsKey("productImages")) {
              _productModel.productImages =
              value!["data"][i]["productImages"][0]["Imagename"];
            }
            _productModel.Description = value!["data"][i]["Description"];
            if (value!["data"][i].containsKey("productPrice")) {
              _productModel.productPrice =
              value!["data"][i]["productPrice"][0]["Price"];
              _productModel.unitId =
                  value!["data"][i]["productPrice"][0]["Id"].toString();
            }
            if (value!["data"][i].containsKey("productCount")) {
              _productModel.count =
              value!["data"][i]["productCount"][0]["quantity"];
            }
            else {
              _productModel.count = 0;
            }
            if (value!["data"][i].containsKey("productCount")) {
              _productModel.price =
              (value!["data"][i]["productPrice"][0]["Price"] *
                  value!["data"][i]["productCount"][0]["quantity"]);
            }
            else {
              _productModel.price = 0;
            }
            productModel.add(_productModel);
            print(_productModel);
            print(_productModel.Id);
          }
          _onChanged(true, value);
          // print(listData);
        });
      }


      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      //_onChanged(value);


    /*  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );*/


    } else {
      pr.hide();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    }
    return parsedJson;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
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
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Stack(
            children: <Widget>[
              pageTitle(context),
              profile_Page(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child:Center(
            child: Text(
              "Product",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4),
            ),
          ),
          )
        ],
      ),
    );
  }

  Widget profile_Page(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
    itemCount: productModel == null ? 0 : productModel.length,
    itemBuilder: (BuildContext context, int index) {
    return productModel[index].IsActive!=0?ListTile(
      title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             Container(
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
                                    "http://adminparty.v2infotech.net/images/productimages/"+
                                        productModel[index].productImages),
                                fit: BoxFit.fill,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 25, top: 0,),
                                      child: Text(
                                       "${productModel[index].Productname}",
                                        maxLines: 1,
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

                                SizedBox(
                                  height: 6,
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
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
                                      Expanded(
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: () =>
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (
                                                            context) =>
                                                            ProductDetail(data: productModel[index].Description, image:productModel[index].productImages))),
                                            child: Text(
                                              "${productModel[index].Description}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                              ),
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
                                              "Rs ${productModel[index].price}",
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
                                              onTap: (){
                                                p=productModel[index].productPrice;
                                                productId=productModel[index].Id.toString();
                                                _removeProduct(productId.toString(),index);
                                              },
                                              child: Container(
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  size: 24,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              padding: const EdgeInsets.only(
                                                  bottom: 2, right: 8, left: 8),
                                              child: Text(
                                                "${productModel[index].count}",
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
                                              onTap: (){

                                                productId=productModel[index].Id.toString();
                                                p=productModel[index].productPrice;

                                                _addProduct(productId.toString(),index);
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

                                    " BASE PRICE : Rs ${productModel[index].productPrice}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                               /* Row(
                                  children: <Widget>[ Expanded(
                                    flex:1,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "Go to Cart",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                  ),
                                    Container(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 24,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                )*/
                              ],
                            ),
                          ),

                        )
                      ],
                    ),
                  ),
                ),
   /*     Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.cancel),
            color: Colors.black,
          ),
        ),*/

              SizedBox(
                height: 18,
              ),

            ],
          ),


    ):Container();

    }
      ),
    );
  }

  Future<Map<String, dynamic>> getCount(String productId,int index, price) async {
    /* print(productId.toString());
  print(id);
  print(counter);*/
    // pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    // pr.show();
    // print(token);
    final response = await http.post(APIS.addPackageCount,
        headers: {'Accept': 'application/json'},
        body: {"productid": productId.toString(),
          "unitid":productModel[index].unitId.toString(),
          "amount":price.toString(),
          "quantity": productModel[index].count.toString(),
          "userid": id.toString()});
    print({"productid": productId.toString(),
      "unitid":productModel[index].unitId.toString(),
      "amount":price.toString(),
      "quantity": productModel[index].count.toString(),
      "userid": id});
    var parsedJson = json.decode(response.body);
    value1 = parsedJson['data'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      // pr.dismiss();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      /*//_onChanged(value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );*/
    } if(parsedJson['status'] == "0") {
      //pr.dismiss();
      Toast.show("" + parsedJson['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      _ackAlert(context);
      /*   Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );*/

    }
    return parsedJson;
  }


  _addProduct(String productId,int index) {
    setState(() {
      productModel[index].count! + 1;
      productModel[index].price=(p!*productModel[index].count!).toString();
      print(productModel[index].price.toString());
      getCount(productId.toString(),index, productModel[index].price);
    /*  sumP=productModel[index].price;
      given_list.add(sumP);
      sum = given_list.fold(0, (previous, current) => previous + current);
      print("Sum wqww: ${sum}");
      print("Sumsdasda : ${given_list}");
        onChanged(true, sum);*/

    });

  }

  _removeProduct(String productId,int index) {
    setState(() {
      if (productModel[index].count! > 0) {
        productModel[index].count! -1;
        productModel[index].price=int.parse(productModel[index].price.toString())-p!;
        getCount(productId.toString(),index, productModel[index].price);

       /* sumP=productModel[index].price;
                                                given_list.remove(int.parse(sumP));
                                                sum = given_list.fold(0, (previous, current) => previous + current);
                                                print("Sum : ${sum}");
                                                print("Sum : ${given_list}");*/
      //  onChanged(true, sum);


      }
    });
  }

  onChanged(bool value,var price) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("price",price.toString());
      sharedPreferences.commit();
    });
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
        }
        else {
          id.clear();
        }
      }
      else {
        checkValue = false;
      }
    });
  }

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("pid", response!["Id"]);
      sharedPreferences.commit();
    });
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
