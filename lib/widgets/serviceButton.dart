import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  VoidCallback ontap;
  String txt;
  Icon? icon;
  ServiceButton({required this.ontap, required this.txt, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(),
    );
  }
}
