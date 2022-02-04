import 'package:flutter/material.dart';
import 'text_field_container.dart';
import 'package:mechanic_helper/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
        validator:(value){
          if(value!.isEmpty){
            return 'Please enter a password';
          }
          if(value.length<6){
            return "Must be more than 6 character";
          }
        }
      ),
    );
  }
}
