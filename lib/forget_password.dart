import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'rest_api/ApiList.dart';
import 'forget_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgotPass();
  }
}

class _ForgotPass extends State<ForgotPass> {
  late SharedPreferences sharedPreferences;
  bool? checkValue;
  Map<String, dynamic>? value;
  final _formkey = GlobalKey<FormState>();
  @override
 final user_NameController = TextEditingController();
  late ProgressDialog pr;

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: GestureDetector(
        onTap: () {

          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(

                    colors: [Colors.black.withOpacity(0.8),Colors.black.withOpacity(0.8),],

                  ),
                  image: DecorationImage(
                    image: AssetImage("images/services_background.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  )
              ),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30,left: 20),
                    child: new Row(
                      children: [
                        new InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                            //_scaffoldKey.currentState.openDrawer();
                          },
                          child: new Container(
                            height: 18,
                            child: new Image.asset("images/back_button.png",),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(

                        alignment: Alignment.center,
                        //padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: AppTheme().color_white,
                              // fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 22),
                        )),
                  ),
                  SizedBox(height: 40.0),

                  Container(
                    width: 100,
                    height: 100,
                    child: Container(
                        margin: EdgeInsets.all(30.0),
                        height: 30.0,
                        width: 30.0,
                        child: Image.asset('images/forgot.png',
                        )),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255,255,255,0.3)),
                  ),
                  /*  Container(
                    alignment: Alignment.center,
                    height: 90,
                   margin: EdgeInsets.only(left: 120.0,right: 120.0),
                    color: Color.fromRGBO(255,255,255,0.3),

                    child: Card(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Image.asset('images/forgot.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),*/
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat-SemiBold",color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10, right: 10.0, top: 8.0),
                      child: Text(
                        'Enter the Phone Number',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat-SemiBold",color: Colors.white),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.only(left: 10, right: 10.0, top: 0, bottom: 0),
                      child: Text(
                        'associated with your account',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat-SemiBold",color: Colors.white),
                      )),

                  Container(
                    margin: EdgeInsets.only(top: 15.0,left: 170.0,right: 170.0),
                    alignment: Alignment.center,
                    child: Divider(height: 2.0,thickness: 2.0,color: Colors.white,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
                    child: TextFormField(
                      maxLength: 10,
                      textAlign: TextAlign.center,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter your contact number';
                        }else if(value.length != 10){
                          return "contact must be of 10 digits";
                        }
                        else{
                          return null;
                        }
                      },
                      style: TextStyle(
                        color: AppTheme().color_red,
                        fontFamily: "Montserrat-SemiBold",
                        fontSize: 17
                      ),
                      keyboardType: TextInputType.phone,
                      controller: user_NameController,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: Colors.white),

                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.white,
                            wordSpacing: 1.0,
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(width: 1,color: Colors.white)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(width: 1,color: Colors.white)
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                              color: AppTheme().color_red,
                              fontFamily: "Montserrat-SemiBold",
                              fontSize: 17
                          ),
                          hintText: " Phone No.",
                          counterText: "",
                          fillColor: AppTheme().color_white),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90,right: 90,top: 30,bottom: 10),
                    child: Container(
                      height: 45,
                      child:ElevatedButton(
                          child: Text("SUBMIT",
                            style: TextStyle(color:AppTheme().color_white,fontWeight: FontWeight.bold,fontSize: 17),),
                          onPressed: () {

                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              setState(() {});

                              _onChanged( user_NameController.text);
                              getCheckData();
                            }
                            else{

                            }
                            /*    if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              setState(() {});
                              UsernameController.text;
                              UserPasswordController.text;
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home+

                                Page()),
                              );
                            }*/

                          }
                      )
                    ),
                  ),
                ],
              )
            )),
      ),
    );
  }
  _onChanged(String contact) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("number", contact);
      sharedPreferences.commit();
    });
  }

  Future<Map<String, dynamic>> getCheckData() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    // print(token);
    final response = await http.post(Uri.parse(APIS.checkRegistration),
        headers: {'Accept': 'application/json'},
        body:
        {
          "value":user_NameController.text
        });
    print(response.body);
    var parsedJson = json.decode(response.body);
    value = parsedJson['result'];
    print("Status = " + parsedJson['status']);
    if (parsedJson['status'] == "1") {
      pr.hide();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          ForgetForm(number: user_NameController.text)), (Route<dynamic> route) => false);

      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgetForm(number: user_NameController.text)),
      );*/
     /* Toast.show("" + parsedJson['message'], context,
          duration: Toast.lengthLong, gravity: Toast.bottom,);*/
    } else if(parsedJson['status'] == "0"){
      pr.hide();
      Toast.show("" + parsedJson['message'],
          duration: Toast.lengthLong, gravity: Toast.bottom,);
    }
    return parsedJson;
  }
}
//decoration: BoxDecoration(
//gradient: LinearGradient(colors: [
//Color.fromRGBO(
//207, 0, 105, 0.8),
//Color.fromRGBO(255, 168, 81, 0.8)
//]))
