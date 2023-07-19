import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  String imgPath;
  Widget body;
  AppBody({required this.imgPath, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.black.withOpacity(0.9)], stops: const [0.0]),
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          )),
      child: body,
    );
  }
}
