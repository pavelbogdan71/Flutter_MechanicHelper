import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class HistoryServiceDetailContainer extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String serviceType;
  final String carBrand;
  final String carModel;

  const HistoryServiceDetailContainer({Key? key,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.serviceType,
    required this.carBrand,
    required this.carModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
                  height: size.height*0.1,
                  width: size.width*0.1,
                  child: Image.asset(getImagePathByServiceType(serviceType)),
                ),
            ),
            Expanded(
                child: Column(
                  children: [
                    Text(serviceType),
                    SizedBox(height: 3,),
                    Text(date),
                    SizedBox(height: 3,),
                    Text(startTime),
                    SizedBox(height: 3,),
                    Text(endTime),
                    SizedBox(height: 3,),
                    Text(carBrand),
                    SizedBox(height: 3,),
                    Divider(thickness: 4,)
                  ],
                ),
            )

          ],
        )
    );
  }

  String getImagePathByServiceType(String serviceType){
    switch(serviceType){
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