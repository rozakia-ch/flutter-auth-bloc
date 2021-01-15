import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String errorText, hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final IconButton suffixIcon;
  const TextFormFieldWidget({
    Key key,
    this.errorText,
    this.hintText,
    this.obsecureText = false,
    this.controller,
    // ignore: avoid_init_to_null
    this.suffixIcon = null,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      controller: controller,
      // keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorText: errorText,
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }
}
