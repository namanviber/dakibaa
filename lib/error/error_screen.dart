import 'package:flutter/material.dart';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Center(
    child: Container(
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
      width : 300,
      height: 250,
      child: Column(
        children: <Widget>[
          const Expanded(
            flex: 1,
            child: Text("",
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset("images/error.png",height: 200,width: 200),
            ),
          ),

          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: const Text("Error occured due to unknown reason. Please try again later.",
                  textAlign: TextAlign.center,maxLines: 3,
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                  child: const Text('Back',
                    style: TextStyle(
                      fontSize: 14 ,
                      height: 1.0 ,
                      color: Colors.white ,
                    ),
                  ),
                  onPressed: (){
                   Navigator.pop(context);
                  })
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    ),
  );
}