// ignore_for_file: missing_return

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/constant.dart';
import 'package:paytm/paytm.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'app_screens/payment_screens/Thankyou_screen.dart';
import 'app_screens/payment_screens/tnxfailScreen.dart';
import 'rest_api/ApiList.dart';

class CheckOutScreen extends StatefulWidget {
  String? id_list;
  var price;
  CheckOutScreen({super.key, this.price, this.id_list});

  @override
  State createState() => _CheckOutScreen(price: price, id_list: id_list);
}

class _CheckOutScreen extends State<CheckOutScreen> {
  String? id_list;
  var price;
  _CheckOutScreen({this.price, this.id_list});
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
  TimeOfDay? _timeOfDay1 = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  Widget build(BuildContext context) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formkey,
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Colors.black.withOpacity(0.9)
              ], stops: const [
                0.0,
              ]),
              image: DecorationImage(
                image: const AssetImage("images/signup_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  /*Container(
                        height: 100.0,
                        width: 120.0,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Image.asset("images/party.png"),
                      ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
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
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 50.0, bottom: 0.0),
                      child: Text(
                        'CHECK OUT',
                        style: TextStyle(
                            color: AppTheme().color_white,
                            //fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: 25),
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 30.0, right: 20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter name";
                        }
                        else if (value.contains(RegExp(r'[#?!@$%^&*-]')) || value.contains(RegExp(r'[0-9]'))){
                          return "Invalid Name";
                        }

                        else {
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 0.0, top: 5.0, bottom: 0.0),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontWeight: FontWeight.bold),
                          hintText: "Full Name",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        } else if (!regex.hasMatch(value)) {
                          return "Enter Valid Email";
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp("[ ]"), allow: false)
                      ],
                      controller: mailController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 0.0, top: 5.0, bottom: 0.0),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontWeight: FontWeight.bold),
                          hintText: "Email address",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter number";
                        } else if (value.length != 10) {
                          return "contact must be of 10 digits";
                        } else {
                          return null;
                        }
                      },
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          counterText: "",
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 0.0, top: 5.0, bottom: 0.0),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontWeight: FontWeight.bold),
                          hintText: "Contact no.",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter address";
                        } else {
                          return null;
                        }
                      },
                      controller: addressController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 0.0, top: 5.0, bottom: 0.0),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontWeight: FontWeight.bold),
                          hintText: "Address",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0),
                    child: InkWell(
                      onTap: () {
                        callDatePicker();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter date";
                          } else {
                            return null;
                          }
                        },
                        enabled: false,
                        controller: dateController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 0.0, top: 5.0, bottom: 0.0),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            errorStyle: const TextStyle(
                              color: Colors.white,
                              wordSpacing: 1.0,
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            filled: true,
                            hintStyle: TextStyle(
                                color: AppTheme().color_red,
                                fontWeight: FontWeight.bold),
                            hintText: "Date",
                            fillColor: AppTheme().color_white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0),
                    child: GestureDetector(
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            getStartTime(context);
                          },
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter time";
                              } else {
                                return null;
                              }
                            },
                            enabled: false,
                            controller: timeController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 0.0, top: 5.0, bottom: 0.0),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                                errorStyle: const TextStyle(
                                  color: Colors.white,
                                  wordSpacing: 1.0,
                                ),
                                errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: AppTheme().color_red,
                                    fontWeight: FontWeight.bold),
                                hintText: "Time",
                                fillColor: AppTheme().color_white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 120.0, top: 25.0, right: 120.0),
                    child: ButtonTheme(
                      minWidth: 360.0,
                      child: ElevatedButton(
                        child: const Text("SUBMIT"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme().color_red,
                          textStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            setState(() {});
                            getData();
                          }
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

  void generateTxnToken(int mode) async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Loading..", barrierDismissible: true);
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": "DLjjoP50683529074696",
      "key_secret": "dM0xTZCzkiKtJF4p",
      "website": "DEFAULT",
      "orderId": orderId,
      "amount": totalamount.toString(),
      "callbackUrl": 'https://securegw-stage.paytm.in',
      "custId": "1",
      "mode": "0",
      "testing": 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;

      // var paytmResponse = Paytm.payWithPaytm(mid,orderId,txnToken,amount.toString(),callBackUrl,false);
      var paytmResponse = Paytm.payWithPaytm(
          mId: "DLjjoP50683529074696",
          orderId: orderId,
          txnToken: txnToken,
          txnAmount: totalamount.toString(),
          callBackUrl: "https://securegw-stage.paytm.in",
          staging: false);
      paytmResponse.then((value) {
        print(value);
        setState(() {
          print("Value is ");
          print(value);
          if (value['error']) {
            pr.close();
            payment_mesg = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              print("vallllllll: ${value["response"]}");
              payment_mesg = value['response']['RESPMSG'];
              payment_txnid = value['response']['TXNID'];
              payment_amount = value['response']['TXNAMOUNT'];
              payment_bank = value['response']['BANKNAME'];
              payment_OrderID = value['response']['ORDERID'];
              if (value['response']['RESPMSG'] == 'Txn Success') {
                pr.close();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ThankYouScreen(OrderID: payment_OrderID ?? "")));
              } else {
                pr.close();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => FailScreen()));
              }
            }
          }

          print("payment_response" + value['response']['TXNID']);
        });
      });
    } catch (e) {
      pr.close();
      print(e);
    }
  }

  Future<Map<String, dynamic>> getData() async {
    ToastContext().init(context);//-> This part
    //  print(myController1.text);
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Loading..", barrierDismissible: true);
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
    final response = await http.post(Uri.parse(APIS.orderDetails), headers: {
      'Accept': 'application/json'
    }, body: {
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
    print("json  :  $jsons");
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['data'];

    if (parsedJson['status'] == "1") {
      pr.close();
      setState(() {
        id_com = id.toString();
        // _onChanged(true, value);
      });
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
      /* sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove("price");*/
      //_onChanged(value);
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
      //     Paytmscreen()));
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ThankYouScreen(OrderID: orderId)));
    } else {
      pr.close();
      Toast.show(
        parsedJson['message'],
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
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
      var formatter = DateFormat('dd-MMM-yyyy');
      String formatted = formatter.format(finaldate);
      print(formatted);
      dateController.text = formatted.toString();
    });
  }

  Future<void> getStartTime(BuildContext context) async {
    // Imagine that this function is
    // more complex and slow.
    timePicked1 = await showTimePicker(
      context: context,
      initialTime: _timeOfDay1 != null ? _timeOfDay1! : TimeOfDay.now(),
    );
    setState(() {
      _timeOfDay1 = timePicked1;
      timeController.text = _timeOfDay1!.format(context).toString();
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
  Future<DateTime?> getDate() {
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
