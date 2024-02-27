// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final String? hintText;
  bool isObscure;
  bool? enable = true;
  CustomTextField({
    Key? key,
    this.controller,
    this.icon,
    this.hintText,
    this.isObscure = true,
    this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        obscureText: isObscure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.blue,
            ),
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText),
      ),
    );
  }
}
