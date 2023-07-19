import 'package:dakibaa/widgets/appBody.dart';
import 'package:flutter/material.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:dakibaa/common/constant.dart';

import '../../widgets/appButton.dart';

class ItemDescription extends StatefulWidget {
  const ItemDescription({super.key});

  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Description",
          style: TextStyle(
              fontSize: 20,
              color: AppTheme().colorWhite,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBody(
        imgPath: "images/services_background.jpg",
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme().colorWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              imageProduct,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            Text(
                              titlename == null ? "" : titlename!,
                              style: TextStyle(
                                  color: AppTheme().colorBlack,
                                  fontFamily: "Montserrat-SemiBold",
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Wrap(
                          children: [
                            Text(
                              descp == null ? "" : descp!,
                              style: TextStyle(
                                  color: AppTheme().colorBlack,
                                  fontFamily: "Montserrat-SemiBold",
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      titlename == "Glassware"
                          ? glasswarename == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: glasswarename.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              glasswarename[index],
                                              style: TextStyle(
                                                  color: AppTheme().colorBlack,
                                                  fontFamily:
                                                      "Montserrat-SemiBold",
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                          : titlename == "Beverage"
                              ? baveragename == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: baveragename.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  baveragename[index],
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme().colorBlack,
                                                      fontFamily:
                                                          "Montserrat-SemiBold",
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                              : Container(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              price == null ? "" : "Price   ₹${price!}",
                              style: TextStyle(
                                  color: AppTheme().colorRed,
                                  fontFamily: "Montserrat-SemiBold",
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            AppButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: "Book Now",
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
