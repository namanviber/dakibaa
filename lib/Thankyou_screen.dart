import 'package:flutter/material.dart';
import 'package:partyapp/number_of_person.dart';

import 'Colors/colors.dart';
import 'common/constant.dart';

class ThankyouScreen extends StatefulWidget {
  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  Future<bool> _onWillPop() async {
   /* Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        Number_of_Person()), (Route<dynamic> route) => false);*/
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      body: new Container(
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
        child: new ListView(
          shrinkWrap: true,
          children: [
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                  child: new Container(
                    height: 100,
                    child: new Image.asset('images/thumsup.gif'),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      child: Text("Thank You",style: TextStyle(color: AppTheme().color_white,fontSize: 35,fontFamily: 'Montserrat'),),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    new Container(
                      child: Text(payment_mesg != null?"Your Order has been placed \nReference Number :  "+payment_OrderID!:""
                        ,textAlign: TextAlign.center,style: TextStyle(color: AppTheme().color_white,fontSize: 15,fontFamily: 'Montserrat-SemiBold'),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 110,left: 110),
                  child: GestureDetector(
                    onTap: () {
                      /*if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            setState(() {});
                            getData();
                          }*/
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          Number_of_Person()), (Route<dynamic> route) => false);
                    },
                    child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppTheme().color_red,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all( color:AppTheme().color_red)
                        ),
                        //margin: EdgeInsets.only(top: 5.0,left: 80,right: 80),
                        child:Center(
                          child: Text("OK".toUpperCase(),style: TextStyle(
                              fontFamily: 'Montserrat',fontSize: 20,color: AppTheme().color_white),),
                        )

                      /*ButtonTheme(

                              minWidth: 360.0,
                              child: RaisedButton(
                                  color: AppTheme().color_red,
                                  disabledColor: AppTheme().color_red,
                                  child: Text("Sign In".toUpperCase(),
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 17,letterSpacing: 2),),
                                  onPressed: () {


                                    if (_formkey.currentState.validate()) {
                                      _formkey.currentState.save();
                                      setState(() {});
                                      getData();
                                    }
                                        if (_formkey.currentState.validate()) {
                                    _formkey.currentState.save();
                                    setState(() {});
                                    UsernameController.text;
                                    UserPasswordController.text;
                                  }else{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  }

                                  },
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                              ),
                            ),*/
                    ),
                  ),
                ),
              ],
            )
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
          ],
        ),
      ),
    ), onWillPop: _onWillPop);
  }
}
