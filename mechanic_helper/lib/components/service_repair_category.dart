import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceRepairCategory extends StatelessWidget {
  final String imagePath;
  final String text;

  const ServiceRepairCategory(
      {Key? key, required this.text, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: size.height * 0.05,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                textStyle: Theme.of(context).textTheme.headline1
            ),
          ),
        ],
      ),
      height: size.height * 0.15,
      width: size.width * 0.21,
      decoration: const BoxDecoration(
        color: Color(0xFFECEFF1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF546E7A),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(4, 5),
          )
        ],
      ),
    );
  }
}
