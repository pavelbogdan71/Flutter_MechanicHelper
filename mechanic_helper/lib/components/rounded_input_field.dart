import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_field_container.dart';
import 'package:mechanic_helper/constants/constants.dart';
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
          hintStyle: GoogleFonts.comfortaa(
            fontSize: 15,
          ),
          border: InputBorder.none,
          ),
        validator:(value) {
          return (!isEmail(value!))?"Invalid Email": null;
        },
      ),
    );
  }
}
