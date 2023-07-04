import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:partyapp/Colors/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'rest_api/ApiList.dart';
import 'home_page.dart';
import 'image_picker_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdate createState() => _ProfileUpdate();
}

class _ProfileUpdate extends State<ProfileUpdate>
    with TickerProviderStateMixin, ImagePickerListener {
  late ImagePickerHandler imagePicker;
  AnimationController? _controller;
  late double screenHeight;
  double? screenwidth;
  File? _image;
  bool? checkValue;
  late ProgressDialog pr;
  Map<String, dynamic>? value;
  var name, id, gender, mobile, dob,email,password, profile_pic;
  late SharedPreferences sharedPreferences;
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? mailController;
  TextEditingController? genderController;
  TextEditingController? dobController;
  TextEditingController? passwordController;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return GestureDetector(
      onTap: () {

        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        body:profile_Page(context),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          child: Container(
            height: screenHeight / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(220, 84, 85, 1),
                Color.fromRGBO(140, 53, 52, 1)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ) ,
            child:  Container(
              margin: EdgeInsets.only(bottom: 220.0),
              child: Center(
                child: Text('UPDATE PROFILE',
                  style: TextStyle(
                      fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),


    );
  }

  Widget profile_Page(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height/1.00,
      decoration: BoxDecoration(
          gradient: RadialGradient(

              colors: [Colors.black.withOpacity(0.9)],
              stops: [0.0, ]
          ),
          image: DecorationImage(
            image: AssetImage("images/signup_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
          )
      ),
      child: ListView(
        children: [
          Form(
            key: _formkey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                  child: Container(

                    alignment: AlignmentDirectional(0.0, 0.0),
                    child:Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10.0,top:0.0),
                      child: Container(
                        child: Column(
                         // crossAxisAlignment: CrossAxisAlignment.center,
                         // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 0,left: 20),
                              child: new Row(
                                children: [
                                  new InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: new Container(
                                      width: 30,
                                      height: 20,
                                      child: Image.asset("images/back_button.png"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 0.0,
                                top: 0.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  /* new GestureDetector(
                                  onTap: () => imagePicker.showDialog(context),
                                  child: new Center(
                                    child: _image == null
                                        ? GestureDetector(
                                      //  onTap: () => imagePicker.showDialog(context),
                                      child: Container(
                                          height: 90.0,
                                          width: 100,
                                          child: new Center(
                                            child: new CircleAvatar(
                                              radius: 60.0,
                                              backgroundImage: NetworkImage(
                                                  "http://partyapp.v2infotech.net/resources/$profile_pic"),
                                              // backgroundColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    40, 0, 0, 40),
                                                child: Image.asset(
                                                  "images/edit.png",
                                                  fit: BoxFit.fill,
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                        : new Container(
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: new BoxDecoration(
                                        // color: Colors.lightBlue,
                                        image: new DecorationImage(
                                          image: new FileImage(_image),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                            color: Colors.black, width: 1.0),
                                        borderRadius: new BorderRadius.all(
                                            const Radius.circular(60.0)),
                                      ),
                                    ),
                                  ),
                                ),*/
                                  new Stack(
                                    children: [
                                      Container(
                                          height: 100.0,
                                          width: 100.0,
                                          margin: EdgeInsets.only(top: 15.0),
                                          child: GestureDetector(
                                            onTap: () => imagePicker.showDialog(context),
                                            child: _image == null
                                                ? new Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: AppTheme().color_white,
                                                    border: Border.all(
                                                        color: AppTheme().color_white,
                                                        width: 5
                                                    )
                                                ),
                                                child:Icon(Icons.person,size: 40,
                                                  color: AppTheme().color_red,)

                                            )
                                                : new Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: AppTheme().color_white,
                                                    border: Border.all(
                                                        color: AppTheme().color_white,
                                                        width: 5
                                                    )
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(200),

                                                  child: Image.file(_image!,fit: BoxFit.cover,),
                                                )

                                            ),
                                          )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 90,left: 60),
                                          child: InkWell(
                                            onTap: ()=> imagePicker.showDialog(context),
                                            child: new Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: AppTheme().color_white,

                                              ),
                                              child: Icon(Icons.add,color: AppTheme().color_red,),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, top: 30.0),
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: AppTheme().color_white,
                                    fontSize: 23.0,
                                    fontFamily: "Montserrat-SemiBold"
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),


                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                                  child: Container(
                                    //margin: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: AppTheme().color_white,
                                              borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: TextFormField(

                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:0.0,top: 0.0,bottom: 0.0),
                                                //isDense: true,
                                                hintStyle:TextStyle(
                                                  color: AppTheme().color_red,
                                                  fontFamily: "Montserrat-SemiBold",
                                                  fontSize: 16,) ,
                                                hintText: "Name"

                                              ),
                                              controller: nameController,
                                              style: TextStyle(
                                                  color: AppTheme().color_red,
                                                  fontFamily: "Montserrat-SemiBold",
                                                  fontSize: 16,)
                                                  //fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                  child: Container(
                                    //margin: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        Expanded(
                                          child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: AppTheme().color_white,
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: TextField(
                                              //maxLength: 10,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:0.0,top: 0.0,bottom: 0.0),
                                                //isDense: true,
                                                  hintStyle:TextStyle(
                                                    color: AppTheme().color_red,
                                                    fontFamily: "Montserrat-SemiBold",
                                                    fontSize: 16,) ,
                                                  hintText: "Contact No."
                                              ),
                                              controller: phoneController,
                                              keyboardType: TextInputType.phone,

                                              style: TextStyle(
                                                color: AppTheme().color_red,
                                                fontFamily: "Montserrat-SemiBold",
                                                fontSize: 16,)
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /* SizedBox(
                                height: 14,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('EMAIL -',
                                      style: TextStyle(
                                          color: Color.fromRGBO(220, 84, 85, 1),
                                          fontFamily: "Raleway",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 246.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left:5.0,top: 10.0,bottom: 2.0),
                                          isDense: true,

                                        ),
                                        controller: mailController,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Raleway",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('GENDER -',
                                      style: TextStyle(
                                          color: Color.fromRGBO(220, 84, 85, 1),
                                          fontFamily: "Raleway",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 234.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left:5.0,top: 10.0,bottom: 2.0),
                                          isDense: true,

                                        ),
                                        controller: genderController,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Raleway",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('D.O.B -',
                                      style: TextStyle(
                                          color: Color.fromRGBO(220, 84, 85, 1),
                                          fontFamily: "Raleway",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      width: 256.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left:5.0,top: 10.0,bottom: 2.0),
                                          isDense: true,

                                        ),
                                        controller: dobController,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Raleway",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                  child: Container(
                                    //margin: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        Expanded(
                                          child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: AppTheme().color_white,
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:0.0,top: 0.0,bottom: 0.0),
                                                //isDense: true,
                                                //enabled: false,
                                                  hintStyle:TextStyle(
                                                    color: AppTheme().color_red,
                                                    fontFamily: "Montserrat-SemiBold",
                                                    fontSize: 16,) ,
                                                  hintText: "Password"

                                              ),
                                              controller: passwordController,
                                              style: TextStyle(
                                                color: AppTheme().color_red,
                                                fontFamily: "Montserrat-SemiBold",
                                                fontSize: 16,)
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15.0),
                                  child: ButtonTheme(

                                    minWidth: 200.0,
                                    child: ElevatedButton(
                                        child: Text("SAVE",
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 17),),
                                        onPressed: () {
                                          if (_formkey.currentState!.validate()) {
                                            if(nameController!.text.isEmpty){
                                              Toast.show("" + "Please enter name", context,
                                                  duration: Toast.lengthLong, gravity: Toast.top,);
                                            } else if (nameController!.text.isEmpty&&phoneController!.text.isEmpty) {
                                              Toast.show("" + "Please enter name and Phone number", context,
                                                  duration: Toast.lengthLong, gravity: Toast.top,);
                                            }
                                            else if (phoneController!.text.isEmpty) {
                                              Toast.show("" + "Please enter Phone number", context,
                                                  duration: Toast.lengthLong, gravity: Toast.top,);
                                            }else if(phoneController!.text.length != 10){
                                              Toast.show("" + "contact must be of 10 digits", context,
                                                  duration: Toast.lengthLong, gravity: Toast.top,);
                                            } else{
                                              updateProfile(
                                                  nameController!.text,
                                                  phoneController!.text,
                                                  "Male",
                                                  "01/01/1990",
                                                  "abc@gmail.com",
                                                  "ljhasfdnnlzs568794544",
                                                  id,
                                                  _image);
                                            }

                                          }
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }


  @override
  void initState() {
    super.initState();
    getCredential();


    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue!) {
          name = sharedPreferences.getString("name");
          if(name==null){
            name="";
          }
          nameController =new TextEditingController(text: "$name");
          print("$name");
          id = sharedPreferences.getString("id");
          gender = sharedPreferences.getString("gender");
          genderController =new TextEditingController(text: "$gender");
          mobile = sharedPreferences.getString("mobile");
          if(mobile==null){
            mobile="";
          }
          phoneController =new TextEditingController(text: "$mobile");

          dob = sharedPreferences.getString("dob");
          dobController =new TextEditingController(text: "$dob");
          email = sharedPreferences.getString("email");
          mailController =new TextEditingController(text: "$email");
          password = sharedPreferences.getString("password");
          if(password==null){
            password="";
          }
          passwordController =new TextEditingController(text: "$password");
          profile_pic = sharedPreferences.getString("profile_pic");

        } else {
          name.clear();
          id.clear();
          gender.clear();
          mobile.clear();
          dob.clear();
          email.clear();
          password.clear();
          profile_pic.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _onChanged(bool value, Map<String, dynamic>? response) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue!);
      sharedPreferences.setString("name", response!["Name"]);
      sharedPreferences.setString("id", response["Id"].toString());
     /* sharedPreferences.setString("gender", response["Gender"]);
      sharedPreferences.setString("dob", response["DOB"]);*/
      sharedPreferences.setString("mobile", response["Mobile"]);
     /* sharedPreferences.setString("email", response["Email"]);*/
      sharedPreferences.setString("password", response["Password"]);
      sharedPreferences.setString("profile_pic", response["ProfilePic"]);
      sharedPreferences.commit();
    });
  }

  var returnData;
  Future<Map<String, dynamic>> updateProfile(String username, String phone,
      String gender,String dob,String email,String dev,String? id, File? image) async {
    print("$username$phone$gender$dob$email$password$id");
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.show();
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse(APIS.updateProfile));


    if(image==null){
//  imageUploadRequest.fields['ext'] = mimeTypeData[1];
      imageUploadRequest.fields['username'] = username;
      imageUploadRequest.fields['phone'] = phone;
      imageUploadRequest.fields['gender'] = gender;
      imageUploadRequest.fields['dob'] = dob;
      imageUploadRequest.fields['email'] = email;
      imageUploadRequest.fields['deviceToken'] = dev;
      imageUploadRequest.fields['id'] = id!;

    }
    else{
      final mimeTypeData =
      lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
      final file = await http.MultipartFile.fromPath('file', image.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

//  imageUploadRequest.fields['ext'] = mimeTypeData[1];
      imageUploadRequest.fields['username'] = username;
      imageUploadRequest.fields['phone'] = phone;
      imageUploadRequest.fields['gender'] = gender;
      imageUploadRequest.fields['dob'] = dob;
      imageUploadRequest.fields['email'] = email;
      imageUploadRequest.fields['deviceToken'] = dev;
      imageUploadRequest.fields['id'] = id!;
      imageUploadRequest.files.add(file);
    }


    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      var parsedJson = json.decode(response.body);
      value = parsedJson['data'];
      print("Status = " + parsedJson['status']);
      if (parsedJson['status'] == "1") {
        pr.hide();
        Toast.show("" + parsedJson['message'], context,
            duration: Toast.lengthShort, gravity: Toast.bottom,);
        setState(() {
          _onChanged(true, value);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        pr.hide();
        Toast.show("" + parsedJson['message'], context,
            duration: Toast.lengthShort, gravity: Toast.bottom,);

      }
      return parsedJson;
    } catch (e) {
      print(e);
    }
    return returnData;

  }
}
