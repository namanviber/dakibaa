import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dakibaa/widgets/appBody.dart';
import 'package:dakibaa/widgets/appTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:dakibaa/Colors/colors.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../rest_api/ApiList.dart';
import '../../image_picker_handler.dart';
import 'package:http_parser/http_parser.dart';
import '../../widgets/appButton.dart';
import 'otpScreen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(this, _controller);
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
        usernameError = 'Enter Name';
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
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: AppTheme().colorBlack,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AppBody(
        imgPath: "images/signup_background.jpg",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                          height: 100.0,
                          width: 100.0,
                          margin: const EdgeInsets.only(top: 15.0),
                          child: GestureDetector(
                            onTap: () => imagePicker.showDialog(context),
                            child: _image == null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().colorWhite,
                                        border: Border.all(
                                            color: AppTheme().colorWhite,
                                            width: 5)),
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: AppTheme().colorRed,
                                    ))
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppTheme().colorWhite,
                                        border: Border.all(
                                            color: AppTheme().colorWhite,
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
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme().colorWhite,
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppTheme().colorRed,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create Your Account",
                      style: TextStyle(
                          color: AppTheme().colorWhite,
                          fontSize: 23.0,
                          fontFamily: "Montserrat-SemiBold"
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  AppTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Name';
                        } else if (value.length < 4 && value.length > 20) {
                          return 'Enter atLeast 4 digit.';
                        } else if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                          return 'Invalid Name.';
                        } else if (value.contains(RegExp(r'[0-9]'))) {
                          return 'Invalid Name.';
                        }
                        return null;
                      },
                      controller: usernameController,
                      hinttext: "Name"),
                  AppTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your contact';
                        } else if (value.length != 10) {
                          return "contact must be of 10 digits";
                        } else {
                          return null;
                        }
                      },
                      isphone: true,
                      controller: contactController,
                      hinttext: "Contact No."),
                  AppTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains("@") ||
                            !value.contains('.')) {
                          return 'Email address is not Valid.';
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      hinttext: "Email ID"),
                  AppTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return "Password range 8 - 15 digits";
                      } else if (value.length > 16) {
                        return "Password range 8 - 15 digits";
                      } else if (!value.contains(RegExp(r'[A-Z]'))) {
                        return "Password should contain upper character";
                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                        return "Password should contain digit";
                      } else if (!value.contains(RegExp(r'[a-z]'))) {
                        return "Password should contain lower chracter";
                      } else if (!value.contains(RegExp(r'[#?!@$%^&*-]'))) {
                        return "Password should contain Special character";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    hinttext: "Password",
                    ispass: true,
                  ),
                  AppTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Password is not matching';
                      }
                      return null;
                    },
                    controller: conPasswordController,
                    hinttext: "Confirm Password",
                    ispass: true,
                  ),
                  AppButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signUp(
                            usernameController.text,
                            contactController.text,
                            "",
                            "01/01/1990",
                            emailController.text,
                            passwordController.text,
                            "ljhasfdnnlzs568794544",
                            _image);
                      }
                    },
                    title: "Sign Up",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp(String username, String phone, String gender, String dob, String email,
      String password, String deviceToken, File? image) async {
    pr = ProgressDialog(
      context: context,
    );
    pr.show(msg: "Processing..", barrierDismissible: true);

    try {
      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(APIS.usersSignUp));

      imageUploadRequest.fields['name'] = username;
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

      print("Data:  ${imageUploadRequest.toString()}");

      final streamedResponse = await imageUploadRequest.send();
      if (streamedResponse.statusCode == 200) {
        final response = await http.Response.fromStream(streamedResponse);
        var parsedJson = json.decode(response.body);
        print("response body: $parsedJson");
        print("Data:  ${parsedJson['data']["recordsets"].toString()}");
        if (parsedJson['status'] == "1") {
          pr.close();
          if (parsedJson['data']["recordsets"]
              .toString()
              .toLowerCase()
              .contains("[[{: 1}]]")) {
            String otp = parsedJson['message']
                .toString()
                .replaceAll("Otp For registration send to your Mobile", "");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  type: 'register',
                  otpphone: otp,
                  mobile: phone,
                ),
              ),
            );
          } else {
            Toast.show(
              parsedJson['data']["recordsets"][0][0]["accRegistered"],
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
            );
          }
        } else {
          pr.close();

          Toast.show(
            parsedJson['data']["recordsets"][0][0]["accRegistered"],
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
        }
      } else {
        pr.close();
        throw Exception();
      }
    } on HttpException {
      Toast.show(
        "Internal Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } on FormatException {
      Toast.show(
        "Server Error",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } on TimeoutException {
      Toast.show(
        "Request time out Try again",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  userImage(File image) {
    setState(() {
      _image = image;
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
