import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../rest_api/ApiList.dart';
import '../../image_picker_handler.dart';
import 'package:http_parser/http_parser.dart';
import '../../otp_screen.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with TickerProviderStateMixin, ImagePickerListener {
  double? screenHeight;
  double? screenwidth;
  AnimationController? _controller;
  late ImagePickerHandler imagePicker;
  late SharedPreferences sharedPreferences;
  late ProgressDialog pr;
  bool passwordVisible = true;
  bool passwordVisible1 = true;
  String? username, contact, password, conPassword;
  String? usernameError, contactError, passwordError, conPasswordError;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController conPasswordController =
      new TextEditingController();
  File? _image;
  late var token;
  bool? checkValue;
  bool status = false;

  List<Company> _companies = Company.getCompanies();
  late List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company? _selectedCompany;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    getCredential();
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    passwordVisible = true;
    passwordVisible1 = true;
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (Company company in companies as Iterable<Company>) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  bool Validation() {
    setState(() {
      status = true;
    });

    usernameError = null;
    contactError = null;
    passwordError = null;
    conPasswordError = null;
    if (username == "" || username == null) {
      setState(() {
        usernameError = 'Enter Username';
        status = false;
      });
    }
    if (contact == "" || contact == null) {
      setState(() {
        contactError = 'Enter Contact No.';
        status = false;
      });
    } else if (contact!.length < 10 || contact!.length > 10) {
      setState(() {
        contactError = 'Enter Correct Contact No.';
        status = false;
      });
    }
    if (password == "" || password == null) {
      setState(() {
        passwordError = 'Enter Person';
        status = false;
      });
    } else if (password!.length < 8) {
      setState(() {
        contactError = 'Enter Enter minimum 8 characters.';
        status = false;
      });
    }
    if (conPassword == password) {
      setState(() {
        conPasswordError = 'Password Not Match';
        status = false;
      });
    }

    return status;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Container(
                width: 30,
                height: 20,
                child: Image.asset("images/back_button.png"),
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: new Container(
        height: screenHeight,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.black.withOpacity(0.9)], stops: [0.0]),
            image: DecorationImage(
              image: AssetImage("images/signup_background.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().color_white,
                                        border: Border.all(
                                            color: AppTheme().color_white,
                                            width: 5)),
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: AppTheme().color_red,
                                    ))
                                : new Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().color_white,
                                        border: Border.all(
                                            color: AppTheme().color_white,
                                            width: 5)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 100, left: 60),
                          child: InkWell(
                            onTap: () => imagePicker.showDialog(context),
                            child: new Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme().color_white,
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppTheme().color_red,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 10.0),
                    child: Text(
                      "Create Your Account",
                      style: TextStyle(
                          color: AppTheme().color_white,
                          fontSize: 23.0,
                          fontFamily: "Montserrat-SemiBold"
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppTheme().color_white),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          errorStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat-SemiBold",
                              color: AppTheme().color_white),
                          hintStyle: new TextStyle(
                              color: Colors.red[800],
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat-SemiBold"),
                          hintText: "Username",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your contact';
                        } else if (value.length != 10) {
                          return "contact must be of 10 digits";
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          errorStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat-SemiBold",
                              color: AppTheme().color_white),
                          hintStyle: new TextStyle(
                              color: AppTheme().color_red,
                              fontFamily: "Montserrat-SemiBold"),
                          hintText: "Contact No.",
                          counterText: "",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      obscureText: passwordVisible1,
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible1 = !passwordVisible1;
                              });
                            },
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.red,
                            )),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0)),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        errorStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: "Montserrat-SemiBold",
                            color: AppTheme().color_white),
                        hintStyle: new TextStyle(
                          color: AppTheme().color_red,
                          fontFamily: "Montserrat-SemiBold",
                        ),
                        hintText: "Password",
                        fillColor: AppTheme().color_white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Password is not matching';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: conPasswordController,
                      obscureText: passwordVisible,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.red,
                              )),
                          errorStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat-SemiBold",
                              color: AppTheme().color_white),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(
                              color: AppTheme().color_red,
                              fontFamily: "Montserrat-SemiBold"),
                          hintText: "Confirm Password",
                          fillColor: AppTheme().color_white),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: screenwidth! * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppTheme().color_red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppTheme().color_red)),
                    child: GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          if (_image != null) {
                            getsignUpData(
                                usernameController.text,
                                contactController.text,
                                "",
                                "01/01/1990",
                                "abc@gmail.com",
                                passwordController.text,
                                "ljhasfdnnlzs568794544",
                                _image);
                          } else {
                            Toast.show("" + "Please select image",
                                duration: Toast.lengthLong,
                                gravity: Toast.top,);
                          }
                        }
                      },
                      child: Center(
                        child: Text(
                          "Sign Up".toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: AppTheme().color_white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var returnData;
  Future<Map<String, dynamic>> getsignUpData(
      String username,
      String phone,
      String gender,
      String dob,
      String email,
      String password,
      String deviceToken,
      File? image) async {
    print("$username$phone$gender$dob$email$password$deviceToken");
    pr = new ProgressDialog(context: context, );
    pr.show();

    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(APIS.usersSignUp));

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.fields['username'] = username;
    imageUploadRequest.fields['phone'] = phone;
    imageUploadRequest.fields['gender'] = gender;
    imageUploadRequest.fields['dob'] = dob;
    imageUploadRequest.fields['email'] = email;
    imageUploadRequest.fields['password'] = password;
    imageUploadRequest.fields['deviceToken'] = deviceToken;

    if (image != null) {
      final mimeTypeData =
          lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final file = await http.MultipartFile.fromPath('file', image.path,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
      imageUploadRequest.files.add(file);
    }
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      var parsedJson = json.decode(response.body);
      print("Status = " + parsedJson['status']);
      if (parsedJson['status'] == "1") {
        pr.close();
        /* Toast.show("" + parsedJson['message'], context,
            duration: Toast.lengthLong, gravity: Toast.bottom,);*/
        _onChanged(parsedJson['message'], phone);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(type: 'register')),
        );
      } else {
        pr.close();
        Toast.show("" + parsedJson['message'],
            duration: Toast.lengthLong, gravity: Toast.bottom,);
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );*/
      }
      return parsedJson;
    } catch (e) {
      print(e);
    }
    return returnData;
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
          token = sharedPreferences.getString("token");
        } else {
          token.clear();

          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _onChanged(String? otp, String contact) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("otp", otp!);
      sharedPreferences.setString("number", contact);
      sharedPreferences.commit();
    });
  }
}

class Company {
  String name;
  int id;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, '+91'),
    ];
  }
}
//validator: (value) {
//if (value.isEmpty) {
//return "contact must be filled";
//}else if(value.length != 10){
//return "Contact must be of 10 digits";
//}
//},
