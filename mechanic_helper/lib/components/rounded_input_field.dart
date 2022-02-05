import 'package:flutter/material.dart';
import 'text_field_container.dart';
import 'package:mechanic_helper/constants.dart';
import 'package:validators/validators.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    this.controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        controller:controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
          ),
        validator:(value) {
          return (!isEmail(value!))?"Invalid Email": null;
        },
      ),
    );
  }
}