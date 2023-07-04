import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/app_screens/payment_screens/Thankyou_screen.dart';
import 'package:partyapp/number_of_person.dart';
import 'package:partyapp/models/paytm_model.dart';
import 'package:partyapp/paytm_presenter.dart';
import 'package:partyapp/app_screens/payment_screens/tnxfailScreen.dart';
import 'package:paytm/paytm.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/constant.dart';
class Paytmscreen extends StatefulWidget {
  @override
  _PaytmscreenState createState() => _PaytmscreenState();
}
class _PaytmscreenState extends State<Paytmscreen>implements PaytmModelContract {
/*  String payment_txnid = null;
  String payment_mesg = null;
  String payment_bank = null;
  String payment_OrderID = null;

  String payment_amount = null;*/

  late PaytmModelPresenter _presenter;

  _PaytmscreenState() {
    _presenter = new PaytmModelPresenter(this);
  }

  //Live
  /* String mid = "LIVE_MID_HERE";
  String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
  String website = "DEFAULT";
  bool testing = false;*/

  // Testing
  String mid = "DLjjoP50683529074696";
  String PAYTM_MERCHANT_KEY = "dM0xTZCzkiKtJF4p";
  String website = "DEFAULT";
  bool testing = false;
  late ProgressDialog pr;
  double amount = 1;
  bool loading = false;
  late SharedPreferences sharedPreferences;
  bool? checkValue;
  var id;
  @override
  void initState() {
    super.initState();
    getCredential();
    amount=double.parse(totalamount.toString()) ;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new Container(
        height: MediaQuery.of(context).size.height,
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
        child:  SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 10),
                      child: new Container(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.arrow_back,color: AppTheme().color_white,size: 25,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 20),
                      child: new Container(
                        child: Text("Paytm Options",style: TextStyle(color: AppTheme().color_white,fontSize: 25,fontFamily: 'Montserrat'),),
                      ),
                    )
                  ],
                ),
                /*Text(
                    'For Testing Credentials make sure Paytm APP is not installed on the device.'),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  onChanged: (value) {
                    mid = value;
                  },
                  decoration: InputDecoration(hintText: "Enter MID here"),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  onChanged: (value) {
                    PAYTM_MERCHANT_KEY = value;
                  },
                  decoration:
                  InputDecoration(hintText: "Enter Merchant Key here"),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  onChanged: (value) {
                    website = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Website here (Probably DEFAULT)"),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  onChanged: (value) {
                    try {
                      amount = double.tryParse(value);
                    } catch (e) {
                      print(e);
                    }
                  },
                  decoration: InputDecoration(hintText: "Enter Amount here"),
                  keyboardType: TextInputType.number,
                ),*/
                SizedBox(
                  height: 50,
                ),
                /*payment_mesg != null
                    ? Text('Transaction Status: $payment_mesg\n',style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat-SemiBold',fontSize: 17),)
                    : Container(),
                payment_txnid != null
                    ? Text('Transaction Id : $payment_txnid\n',style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat-SemiBold',fontSize: 15),)
                    : Container(),
                payment_OrderID != null
                    ? Text('Transaction OrderId : $payment_OrderID\n',style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat-SemiBold',fontSize: 15),)
                    : Container(),
                payment_bank != null
                    ? Text('Transaction Type : $payment_bank\n',style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat-SemiBold',fontSize: 15),)
                    : Container(),
                payment_amount != null
                    ? Text('Transaction Amount: $payment_amount\n',style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat-SemiBold',fontSize: 15),)
                    : Container(),*/
//                loading
//                    ? Center(
//                        child: Container(
//                            width: 50,
//                            height: 50,
//                            child: CircularProgressIndicator()),
//                      )
//                    : Container(),
                ElevatedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(0);
                  },
                  child: Text(
                    "Pay using Wallet"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme().color_red,
                    textStyle: TextStyle(color:AppTheme().color_white,fontFamily: 'Montserrat',fontSize: 17),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(1);
                  },
                  child: Text(
                    "Pay using Net Banking"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme().color_red,
                    textStyle: TextStyle(color:AppTheme().color_white,fontFamily: 'Montserrat',fontSize: 17),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(2);
                  },
                  child: Text(
                    "Pay using UPI"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme().color_red,
                    textStyle: TextStyle(color:AppTheme().color_white,fontFamily: 'Montserrat',fontSize: 17),
                  ),
                ),
               /* RaisedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(3);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppTheme().color_red,
                  child: Text(
                    "Pay using Credit Card",
                    style: TextStyle(color: AppTheme().color_white,fontFamily: 'Montserrat',fontSize: 17),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void generateTxnToken(int mode) async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
        ? 'https://securegw-stage.paytm.in'
        : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId ;
    print("orderId:   "+orderId);
    //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
    //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": PAYTM_MERCHANT_KEY,
      "website": website,
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callBackUrl,
      "custId": "1",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;

      // var paytmResponse = Paytm.payWithPaytm(mid,orderId,txnToken,amount.toString(),callBackUrl,false);
      var paytmResponse = Paytm.payWithPaytm(mId: mid, orderId: orderId, txnToken: txnToken, txnAmount: amount.toString(), callBackUrl: callBackUrl, staging: false);
      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          print("Value is ");
          print(value);
          if(value['error']){
            pr.hide();
            payment_mesg = value['errorMessage'];
          }else{
            if(value['response']!=null){
              if(value['response']['RESPMSG']=='Txn Success'){
                pr.hide();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    ThankyouScreen()));
                _presenter.getpaytm(value['response']['ORDERID'], value['response']['BANKNAME'], value['response']['TXNID'], id);
              }else{
                pr.hide();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    FailScreen()));
              }
              payment_mesg = value['response']['RESPMSG'];
              payment_txnid = value['response']['TXNID'];
              payment_amount = value['response']['TXNAMOUNT'];
              payment_bank = value['response']['BANKNAME'];
              payment_OrderID = value['response']['ORDERID'];
            }
          }

          print("payment_response"+value['response']['TXNID']);
        });
      });
    } catch (e) {
      pr.hide();
      print(e);
    }
  }

  @override
  void onPaytmModelError(String errorTxt) {
    // TODO: implement onPaytmModelError
    print("Error:   "+ errorTxt);
  }

  @override
  void onPaytmModelSuccess(PaytmModel response) {
    // TODO: implement onPaytmModelSuccess
    if(response!=null){
      setState(() {
        paytmModel=response;
      });
    }
  }
}
