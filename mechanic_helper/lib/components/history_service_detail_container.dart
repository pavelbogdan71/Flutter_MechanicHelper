import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';

import '../constants/strings.dart';

class HistoryServiceDetailContainer extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String serviceType;
  final String carBrand;
  final String carModel;

  const HistoryServiceDetailContainer(
      {Key? key,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.serviceType,
      required this.carBrand,
      required this.carModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          width: size.width*0.85,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20
                ),
                width: size.width*0.23,
                height: size.height*0.1,
                child: Image.asset(getImagePathByServiceType(serviceType)),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                        serviceType,
                      style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade900,
                          fontSize: 16,
                          textStyle: Theme.of(context).textTheme.headline1),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(date),
                    SizedBox(
                      height: 3,
                    ),
                    Text(startTime+'-'+endTime),
                    SizedBox(
                      height: 3,
                    ),
                    Text(carBrand+' '+carModel),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: const BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF546E7A),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ],
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  String getImagePathByServiceType(String serviceType) {
    switch (serviceType) {
      case oilChangeDetailsTitle:
        return oilChangeHomepageImagePath;
      case tireReplacementDetailsTitle:
        return tireReplacementHomepageImagePath;
      case batteryReplacementDetailsTitle:
        return batteryReplacementHomepageImagePath;
      case brakeRepairDetailsTitle:
        return brakeRepairHomepageImagePath;
      case wheelBalanceDetailsTitle:
        return wheelBalanceHomepageImagePath;
      case gearboxServiceDetailsTitle:
        return gearboxServiceHomepageImagePath;
      case suspensionServiceDetailsTitle:
        return suspensionServiceHomepageImagePath;
    }

    return carCheckHomepageImagePath;
  }
}
