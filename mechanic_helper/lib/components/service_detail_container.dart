import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants.dart';

class ServiceDetailContainer extends StatelessWidget {
  final String imagePath;
  final Widget priceWidget;
  final String serviceType;
  final Widget serviceTimeInHours;

  const ServiceDetailContainer(
      {Key? key,
      required this.imagePath,
      required this.priceWidget,
      required this.serviceType,
      required this.serviceTimeInHours})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFFECEFF1),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_sharp),
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            imagePath,
            width: size.height * 0.2,
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceType,
                    style: GoogleFonts.comfortaa(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.headline1,
                        color: Color(0xFFECEFF1)),
                  ),
                  Divider(
                    color: Color(0xFF546E7A),),
                  SizedBox(height:10),
                  Text('Description',
                    style: GoogleFonts.comfortaa(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textStyle: Theme.of(context).textTheme.headline1,
                      color: Color(0xFFECEFF1)),
                  ),
                  SizedBox(height: 10,),
                  Text('An Oil Change is the act of removing the used oil in your engine and replacing it with new, clean oil. Over time, oil breaks down and gets dirty. These factors make oil much less slippery and less effective at their job of lubricating engine parts.',
                    style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFECEFF1)),
                  ),
                  SizedBox(height: 20,),
                  priceWidget,
                  SizedBox(height: 10,),
                  serviceTimeInHours
                ],
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF546E7A),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(4, 5),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
