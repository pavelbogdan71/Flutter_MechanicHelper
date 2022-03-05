import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/constants/strings.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/appointment/appointment_screen.dart';
import 'package:page_transition/page_transition.dart';

class ServiceDetailContainer extends StatelessWidget {
  final String imagePath;
  final Widget priceWidget;
  final String serviceType;
  final Widget serviceTimeInHours;
  final String description;
  final int timeForRepair;
  final CarDetailsModel carDetailsModel;

  const ServiceDetailContainer(
      {Key? key,
      required this.imagePath,
      required this.priceWidget,
      required this.serviceType,
      required this.serviceTimeInHours,
      required this.description,
        required this.timeForRepair,
      required this.carDetailsModel})
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
              SizedBox(
                width: 5,
              ),
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
          Container(
            height: size.height * 0.25,
            child: Image.asset(
              imagePath,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
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
                    color: Color(0xFF546E7A),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description',
                    style: GoogleFonts.comfortaa(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.headline1,
                        color: Color(0xFFECEFF1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFECEFF1)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Color(0xFFECEFF1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      priceWidget,
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Color(0xFFECEFF1),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      serviceTimeInHours
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: SizedBox(
                    width: size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: AppointmentScreen(
                                  serviceHours: timeForRepair,
                                  carDetailsModel: carDetailsModel,
                                ),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: kPrimaryColor,
                          ),
                          Text(
                            'Add appointment',
                            style: GoogleFonts.comfortaa(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ],
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.white),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.blueGrey.shade100)),
                    ),
                  ))
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
