import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import '../enums/appointment_status_enum.dart';
import '../models/car_details_model.dart';

class HistoryServiceDetailPopupContainer extends StatelessWidget {

  final String date;
  final String startTime;
  final String endTime;
  final String serviceType;
  final AppointmentStatusEnum status;
  final CarDetailsModel carDetailsModel;


  const HistoryServiceDetailPopupContainer(
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
          Container(
            child: Text('ass'),

          )
      ],
    );
  }

}