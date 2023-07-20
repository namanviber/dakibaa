import 'package:flutter/material.dart';
import '../Colors/colors.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;
  OutlinedBorder? shape;
  double height;
  double width;
  IconData? icon;

  AppButton(
      {required this.onPressed,
      required this.title,
      this.shape,
      this.height = 60,
      this.width = 220,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: AppTheme().colorRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textStyle: TextStyle(
              fontSize: 17,
              color: AppTheme().colorWhite,
              fontFamily: "Montserrat-SemiBold"),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (icon == null)
                ? Container()
                : Icon(
                    icon,
                    color: AppTheme().colorWhite,
                    size: 17,
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }

}
