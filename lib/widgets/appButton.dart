import 'package:flutter/material.dart';
import '../Colors/colors.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;
  OutlinedBorder? shape;
  double height;
  double width;
  IconData? icon;

  AppButton({required this.onPressed, required this.title, this.shape, this.height = 40, this.width = 200, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppTheme().colorRed,
            shape: shape ?? const StadiumBorder(),
            textStyle: TextStyle(fontSize: 17, color: AppTheme().colorWhite, fontFamily: "MontBlancDemo-Bold"),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon == null) ? Container() : Icon(icon, color: AppTheme().colorWhite, size: 17,),
              SizedBox(width: 5,),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //              Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 70, vertical: 50),
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       color: AppTheme().colorRed,
//                       borderRadius: BorderRadius.circular(50),
//                       border: Border.all(color: AppTheme().colorRed)),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (_formkey.currentState!.validate()) {
//                         forgetPassword();
//                       }
//                     },
//                     child: Center(
//                       child: Text(
//                         "Submit".toUpperCase(),
//                         style: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontSize: 20,
//                             color: AppTheme().colorWhite),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
}
