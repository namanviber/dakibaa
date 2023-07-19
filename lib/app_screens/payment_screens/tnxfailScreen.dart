import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';

import '../home_screens/guestCount.dart';

class FailScreen extends StatefulWidget {
  const FailScreen({super.key});

  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  Future<bool> _onWillPop() async {
    /* Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        Number_of_Person()), (Route<dynamic> route) => false);*/
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
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
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                      child: SizedBox(
                        height: 100,
                        child: Image.asset('images/fail.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Transaction Fail",style: TextStyle(color: AppTheme().colorWhite,fontSize: 35,fontFamily: 'Montserrat'),),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 110,left: 110),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              const Number_of_Person()), (Route<dynamic> route) => false);
                        },
                        child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppTheme().colorRed,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all( color:AppTheme().colorRed)
                            ),
                            //margin: EdgeInsets.only(top: 5.0,left: 80,right: 80),
                            child:Center(
                              child: Text("OK".toUpperCase(),style: TextStyle(
                                  fontFamily: 'Montserrat',fontSize: 20,color: AppTheme().colorWhite),),
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
        ));
  }
}

