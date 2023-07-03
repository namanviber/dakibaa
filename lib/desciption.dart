import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:partyapp/common/constant.dart';

class ItemDescription extends StatefulWidget {
  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new Expanded(
                      flex: 1,
                      child: new InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //_scaffoldKey.currentState.openDrawer();
                        },
                        child: new Container(
                          height: 18,
                          child: new Image.asset(
                            "images/back_button.png",
                          ),
                        ),
                      )),
                  //

                  new Expanded(
                    flex: 4,
                    child: new Container(
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text("Description",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppTheme().color_white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 3,
                    child: new Container()
                  ),
                  /*new Expanded(
                        child:Padding(
                          padding: const EdgeInsets.only(left:0,right: 0),
                          child: new Container(
                            margin: EdgeInsets.all(5),
                            height: 45 ,
                            decoration: BoxDecoration(
                                color: AppTheme().color_white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: new Image.asset("images/profile.png",),
                          ),
                        ))*/
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 25),
              child: new Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme().color_white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                      topRight:Radius.circular(10) ),

                ),
                child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                      topRight:Radius.circular(10),bottomLeft:Radius.circular(10) ,bottomRight:Radius.circular(10)  ),
                  child: Image.asset(
                    "images/categorys_image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
              child: new Container(

                decoration: BoxDecoration(
                  color: AppTheme().color_white,
                  borderRadius: BorderRadius.all(Radius.circular(10)  ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black, blurRadius: 5, offset: Offset(0, 5))
                    ],
                ),
                child:new Column(
                  children: [
                   new Container(
                     height: 200,
                     child:  Padding(
                       padding: const EdgeInsets.all(10),
                       child: ClipRRect(
                         borderRadius: BorderRadius.all(Radius.circular(10)  ),
                         child: Image.asset(
                           imageProduct,
                           fit: BoxFit.cover,
                           width: MediaQuery.of(context).size.width,
                         ),
                       ),
                     ),
                   ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10),
                      child: new Row(
                        children: [
                          new Container(
                            child: new Text(titlename==null?"":titlename!,style: TextStyle(color: AppTheme().color_black,fontFamily: "Montserrat-SemiBold",fontSize: 17),
                          ))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
                      child: new Wrap(
                        children: [
                          new Container(
                              child: new Text(descp==null?"":descp!,style: TextStyle(color: AppTheme().color_black,
                                  fontFamily: "Montserrat-SemiBold",fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                    titlename=="Glassware"?glasswarename==null?new Container():Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: new Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: glasswarename.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: new Container(
                                child: new Row(
                                  children: [
                                    new Container(
                                      child: Text(glasswarename[index],style: TextStyle(
                                          color: AppTheme().color_black,
                                          fontFamily: "Montserrat-SemiBold",fontSize: 14
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ):
                    titlename=="Beverage"?baveragename==null?new Container():Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: new Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: baveragename.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: new Container(
                                child: new Row(
                                  children: [
                                    new Container(
                                      child: Text(baveragename[index],style: TextStyle(
                                          color: AppTheme().color_black,
                                          fontFamily: "Montserrat-SemiBold",fontSize: 14
                                      ),),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ):new Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                      child: new Row(
                        children: [
                          new Container(
                              child: new Text(price==null?"":"Price   "+"₹"+price!,style: TextStyle(color: AppTheme().color_red,fontFamily: "Montserrat-SemiBold",fontSize: 18),
                              ))
                        ],
                      ),
                    ),

                  ],
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 20),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: new Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme().color_red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:Center(
                      child: Text("Book Now",style: TextStyle(color: AppTheme().color_white,fontFamily: "Montserrat",fontSize: 17),),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
