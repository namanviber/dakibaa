import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:partyapp/Colors/colors.dart';
class NetworkConnection{

  static Future<bool> check()async{
    var connectivityResult=await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.mobile){
      return true;
    }else if(connectivityResult==ConnectivityResult.wifi){
      return true;
    }else{
      return false;
    }
  }
}

class InternetConnection extends StatefulWidget {
  @override
  _InternetConnectionState createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  final GlobalKey<ScaffoldState>_globalKey=new GlobalKey<ScaffoldState>();
  internet(){
    NetworkConnection.check().then((internet){
      if(internet!=null&&internet){
        Navigator.of(context);
      }else{
        showInSnackBar('Internet Connection Not available Please try again.....');
      }
    });
  }
  void showInSnackBar(String value){
    var snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 20),
              child: new Row(
                children: [
                  new InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: new Container(
                      child: new Image.asset("images/back_button.png",width: 20,height: 20,color: AppTheme().color_black,),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
              child: new Container(
                child:Image.asset("images/internet.jpg") ,
              ),
            ),
          ],
        )
    );
  }
}