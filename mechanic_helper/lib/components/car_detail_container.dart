import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: 6,),
          Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          )
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
    );
  }
}
