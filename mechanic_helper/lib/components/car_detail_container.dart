import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailContainer extends StatelessWidget {
  final String content;
  final Icon icon;
  final String title;

  const CarDetailContainer({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.40,
      height: size.height * 0.1,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 4,),
          Flexible(
            child: Text(
              title,
              style: GoogleFonts.comfortaa(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  textStyle: Theme.of(context).textTheme.headline1),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            content,
            style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                textStyle: Theme.of(context).textTheme.headline1),
          )
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 1),
          )
        ],
      ),
    );
  }
}
