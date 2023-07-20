import 'dart:convert';
import 'dart:io';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appButton.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'checkoutScreen.dart';
import 'package:dakibaa/app_screens/home_screens/itemDescription.dart';
import 'package:dakibaa/app_screens/home_screens/servicesData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import '../../common/constant.dart';
import 'package:dakibaa/rest_api/ApiList.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/models/serviceModel.dart';

class Services extends StatefulWidget {
  @override
  ServicesPage createState() => ServicesPage();
}

class ServicesPage extends State<Services> {
  AnimationController? _controller;
  double? screenHeight;
  double? screenwidth;
  int counter = 0;
  late SharedPreferences sharedPreferences;
  var id;
  File? _image;
  bool _isProgressBarShown = true;
  bool hasData = false;
  Map? data;
  List? listData;
  MediaQueryData? queryData;
  List<ServiceModelNew>? SERVICES_LIST;
  var pic_list = [
    "images/bartender.jpg",
    "images/beverage.jpg",
    "images/butler.jpg",
    "images/glassware.jpg"
  ];

  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http.get(Uri.parse(APIS.ProductDetails));
    var parsedJson = json.decode(response.body);
    data = json.decode(response.body);
    if (parsedJson["status"] == "1") {
      if (mounted) {
        setState(() {
          listData = data!["data"];
          SERVICES_LIST =
              listData!.map((e) => ServiceModelNew.fromJson(e)).toList();
          _isProgressBarShown = false;
        });
      }
      hasData = true;
    }
  }

  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    bool? checkedValue_1=true;
    bool? checkedValue_2=true;
    getData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Services",
              style: TextStyle(
                  fontSize: 20,
                  color: AppTheme().colorWhite,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2),
            ),
            AppButton(
                onPressed: () {
                  if (totalAmount == 0) {
                    Toast.show(
                      "Please select any one product",
                      duration: Toast.lengthShort,
                      gravity: Toast.bottom,
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutScreen()));
                  }
                },
                title: "Next",
                width: 150),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBody(
        imgPath: "images/services_background.jpg",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            SERVICES_LIST == null
                ? Expanded(child: itemLoading())
                : Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.height < 700.0
                                    ? MediaQuery.of(context).size.height / 780
                                    : MediaQuery.of(context).size.height / 1000,
                            mainAxisSpacing: 22),
                        itemCount:
                            SERVICES_LIST == null ? 0 : SERVICES_LIST!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  titlename = SERVICES_LIST![index].productname;
                                  imageProduct = pic_list[index];
                                  descp = SERVICES_LIST![index].productDescr;
                                  if (person! <= 15) {
                                    price =
                                        SERVICES_LIST![index].rate15.toString();
                                  } else if (person! <= 30) {
                                    price =
                                        SERVICES_LIST![index].rate30.toString();
                                  } else if (person! <= 50) {
                                    price =
                                        SERVICES_LIST![index].rate50.toString();
                                  } else if (person! <= 75) {
                                    price =
                                        SERVICES_LIST![index].rate75.toString();
                                  } else if (person! <= 1000) {
                                    price = SERVICES_LIST![index]
                                        .rate100
                                        .toString();
                                  }
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemDescription()),
                                );
                              },
                              child: Counter(
                                index: index,
                                listData: SERVICES_LIST,
                              ));
                        })),
            const SizedBox(
              height: 20,
            ),
            SERVICES_LIST == null
                ? itemtotalLoading()
                : AppButton(
                    onPressed: () {
                      if (totalAmount == 0) {
                        Toast.show(
                          "Please select any one product",
                          duration: Toast.lengthShort,
                          gravity: Toast.bottom,
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutScreen()));
                      }
                    },
                    title: "Total Amount: $totalAmount",
                    width: MediaQuery.of(context).size.width,
                  ),
            Padding(padding: EdgeInsets.only(top: 20))
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

  Widget itemtotalLoading() {
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
                          height: 45.0,
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
