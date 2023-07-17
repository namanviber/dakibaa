import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Colors/colors.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> imageslist = [
    'images/about.jpg',
    'images/about-2.jpg',
    'images/banner1.jpg',
    'images/banner2.jpg',
    'images/banner3.jpg',
    'images/bartender.jpg',
    'images/beverage.jpg',
    'images/bg.jpg',
    'images/butler.jpg',
    'images/contact-title.jpg',
    'images/corporateparty.jpg',
    'images/crokerey.jpg',
    'images/gallery_1.jpg',
    'images/gallery_2.jpg',
    'images/gallery_3.jpg',
    'images/glassware.jpg'
  ];
  var picture;
  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: openCamera,
                    child: const Text('Take a picture'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    onTap: openGallery,
                    child: const Text('Select from gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    picture = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    );
  }

  void openGallery() async {
    picture = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: InkWell(
      //   onTap: () {
      //     openCamera();
      //   },
      //   child: new Container(
      //     height: 50,
      //     color: AppTheme().color_red,
      //     child: new Center(
      //       child: Text(
      //         "Take a Picture",
      //         style: TextStyle(
      //             color: AppTheme().color_white,
      //             fontSize: 17,
      //             fontFamily: 'Montserrat-SemiBold'),
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Container(
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
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 20,
                                    child:
                                        Image.asset("images/back_button.png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                                padding: const EdgeInsets.only(
                                  left: 0.0,
                                  right: 0.0,
                                  top: 10.0,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "images/gallery.png",
                                    color: AppTheme().colorWhite,
                                    fit: BoxFit.cover,
                                    height: 60,
                                  ),
                                )),
                          ),
                          Center(
                            child: Text(
                              "Gallery",
                              style: TextStyle(
                                fontSize: 30,
                                color: AppTheme().colorWhite,
                                //fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat-SemiBold",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: GridView.builder(
                        itemCount: imageslist.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: GridTile(
                              child: Image.asset(
                                imageslist[index],
                                fit: BoxFit.cover,
                              ), //just for testing, will fill with image later
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
