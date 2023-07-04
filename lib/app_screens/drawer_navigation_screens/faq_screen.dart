import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

import '../../rest_api/ApiList.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FaqScreen1();
  }
}

class FaqScreen1 extends State<FaqScreen> {
  List? listData;
  Map? data;
  bool isSelected = false;
  List<bool> setVisible = [];
  bool _isProgressBarShown = true;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: new Container(
                height: 18,
                child: new Image.asset(
                  "images/back_button.png",
                ),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Colors.black.withOpacity(0.9)
              ], stops: [
                0.0,
              ]),
              image: DecorationImage(
                image: AssetImage("images/services_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )),
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Center(
                child: Image.asset(
                  "images/faqs.png",
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "FAQs",
                    style: TextStyle(
                        color: AppTheme().color_white,
                        fontFamily: "Montserrat-SemiBold",
                        //fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              _isProgressBarShown
                  ? itemLoading()
                  : Expanded(
                      child: hasData == true
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  listData == null ? 0 : listData!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 20, left: 20, bottom: 10),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme().color_white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: ExpansionTile(
                                        childrenPadding:
                                            EdgeInsets.only(top: 0, bottom: 20),
                                        title: Container(
                                          height: 50,
                                          margin: EdgeInsets.only(top: 0),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(0.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    "${listData![index]["Question"]}",
                                                    style: TextStyle(
                                                      color:
                                                          AppTheme().color_red,
                                                      //letterSpacing: 3,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                flex: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: [
                                          Visibility(
                                            visible: setVisible[index],
                                            child: new Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, top: 5),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                "${listData![index]["Answer"]}",
                                                style: TextStyle(
                                                  color: AppTheme().color_red,
                                                  //letterSpacing: 3,
                                                  fontFamily:
                                                      "Montserrat-Medium",
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              })
                          : Container(),
                    ),
            ],
          )),
    );
  }

  Future getData() async {
    _isProgressBarShown = true;
    http.Response response = await http.get(APIS.faq);
    data = json.decode(response.body);
    setState(() {
      listData = data!["data"];
      print(listData);
      _isProgressBarShown = false;
    });
    for (int i = 0; i < listData!.length; i++) {
      setVisible.add(true);
      print(setVisible.length);
    }
    hasData = true;
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
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 10)),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 10)),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 10)),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 10)),
                new Row(
                  children: [
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 10)),
              ],
            )));
  }
}
