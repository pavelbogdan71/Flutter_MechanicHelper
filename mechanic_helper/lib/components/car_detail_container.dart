import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarDetailContainer extends StatelessWidget {
  final Widget child;
  final Icon icon;
  final String title;

  const CarDetailContainer({
    Key? key,
    required this.child,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width*0.40,
      height: size.height*0.1,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(children: <Widget>[
            icon,
            Text(title)
          ]),
          child
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.blueGrey,
      ),
    );
  }
}
