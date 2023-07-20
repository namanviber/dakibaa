import 'package:flutter/material.dart';

import '../Colors/colors.dart';

class AppTextField extends StatefulWidget {
  FormFieldValidator validator;
  TextEditingController controller;
  bool isphone;
  bool ispass;
  bool readonly;
  bool enabled;
  String hinttext;    
  AppTextField(
      {required this.validator,
      required this.controller,
      this.isphone = false,
      this.ispass = false,
      this.readonly = false,
      this.enabled = true,
      required this.hinttext,
      super.key});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool passvisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextFormField(
        maxLength: (widget.isphone) ? 10 : null,
        validator: widget.validator,
        textAlign: TextAlign.center,
        controller: widget.controller,
        readOnly: widget.readonly,
        enabled: widget.enabled,
        keyboardType:
            (widget.isphone) ? TextInputType.phone : TextInputType.text,
        cursorColor: AppTheme().colorRed,
        obscureText: (widget.ispass) ? passvisible : false,
        decoration: InputDecoration(
            suffixIcon: (widget.ispass)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        passvisible = !passvisible;
                      });
                    },
                    icon: Icon(
                      passvisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.red,
                    ),
                  )
                : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            errorStyle: TextStyle(
                fontSize: 15,
                fontFamily: "Montserrat-SemiBold",
                color: AppTheme().colorWhite),
            hintStyle: TextStyle(
                color: AppTheme().colorRed, fontFamily: "Montserrat-SemiBold"),
            hintText: widget.hinttext,
            counterText: "",
            fillColor: AppTheme().colorWhite),
      ),
    );
  }
}
