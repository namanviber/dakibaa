import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/constant.dart';

class ItemDescription extends StatefulWidget {
  const ItemDescription({super.key});

  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              image: const AssetImage("images/services_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),

        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //_scaffoldKey.currentState.openDrawer();
                        },
                        child: SizedBox(
                          height: 18,
                          child: Image.asset(
                            "images/back_button.png",
                          ),
                        ),
                      )),
                  //

                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text("Description",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppTheme().colorWhite,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container()
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
              child: Container(

                decoration: BoxDecoration(
                  color: AppTheme().colorWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(10)  ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 5, offset: Offset(0, 5))
                    ],
                ),
                child:Column(
                  children: [
                   SizedBox(
                     height: 200,
                     child:  Padding(
                       padding: const EdgeInsets.all(10),
                       child: ClipRRect(
                         borderRadius: const BorderRadius.all(Radius.circular(10)  ),
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
                      child: Row(
                        children: [
                          Text(titlename==null?"":titlename!,style: TextStyle(color: AppTheme().colorBlack,fontFamily: "Montserrat-SemiBold",fontSize: 17),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
                      child: Wrap(
                        children: [
                          Text(descp==null?"":descp!,style: TextStyle(color: AppTheme().colorBlack,
                              fontFamily: "Montserrat-SemiBold",fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    titlename=="Glassware"?glasswarename==null?Container():Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: glasswarename.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(glasswarename[index],style: TextStyle(
                                    color: AppTheme().colorBlack,
                                    fontFamily: "Montserrat-SemiBold",fontSize: 14
                                ),)
                              ],
                            ),
                          );
                        },
                      ),
                    ):
                    titlename=="Beverage"?baveragename==null?Container():Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: baveragename.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(baveragename[index],style: TextStyle(
                                    color: AppTheme().colorBlack,
                                    fontFamily: "Montserrat-SemiBold",fontSize: 14
                                ),)
                              ],
                            ),
                          );
                        },
                      ),
                    ):Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                      child: Row(
                        children: [
                          Text(price==null?"":"Price   ₹${price!}",style: TextStyle(color: AppTheme().colorRed,fontFamily: "Montserrat-SemiBold",fontSize: 18),
                          )
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
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme().colorRed,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:Center(
                      child: Text("Book Now",style: TextStyle(color: AppTheme().colorWhite,fontFamily: "Montserrat",fontSize: 17),),
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
