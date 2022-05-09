import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/external_libs/open_container.dart';

import '../constants/strings.dart';
import '../enums/appointment_status_enum.dart';
import '../models/car_details_model.dart';
import 'history_service_detail_popup_container.dart';

class HistoryServiceDetailContainer extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final String serviceType;
  final AppointmentStatusEnum status;
  final CarDetailsModel carDetailsModel;

  const HistoryServiceDetailContainer(
      {Key? key,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.serviceType,
      required this.status,
       required this.carDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        OpenContainer(
          closedBuilder: (BuildContext context, VoidCallback _) => Column(
            children: [
              Container(
                width: size.width * 0.85,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: size.width * 0.23,
                      height: size.height * 0.1,
                      child:
                          Image.asset(getImagePathByServiceType(serviceType)),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            serviceType,
                            style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.w900,
                                color: Colors.grey.shade900,
                                fontSize: 16,
                                textStyle:
                                    Theme.of(context).textTheme.headline1),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(date),
                          SizedBox(
                            height: 3,
                          ),
                          Text(startTime + '-' + endTime),
                          SizedBox(
                            height: 3,
                          ),
                          Text(carDetailsModel.brand + ' ' + carDetailsModel.model),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFECEFF1),
                ),
              ),
            ],
          ),
          openBuilder: (BuildContext context, VoidCallback _) =>
              HistoryServiceDetailPopupContainer(
                  date: date,
                  startTime: startTime,
                  endTime: endTime,
                  serviceType: serviceType,
                  status: status,
                  carDetailsModel: carDetailsModel,),
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          closedElevation: 20,
          openColor: Colors.white,
          transitionType: ContainerTransitionType.fade,
        ),
        SizedBox(
          height: 10,
        ),
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
