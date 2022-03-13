import 'dart:ui';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

import '../../external_libs/time_range.dart';

class AppointmentScreen extends StatefulWidget {
  final int serviceHours;
  final CarDetailsModel carDetailsModel;
  final String serviceType;

  const AppointmentScreen(
      {Key? key, required this.serviceHours, required this.carDetailsModel,required this.serviceType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      AppointmentScreenState(serviceHours, carDetailsModel,serviceType);
}

class AppointmentScreenState extends State<AppointmentScreen> {
  final int serviceHours;
  final CarDetailsModel carDetailsModel;
  final String serviceType;

  DateTime selectedDate = getInitalSelectedDate();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  int daysToPick = 30;
  bool canDoAppointment = false;

  AppointmentScreenState(this.serviceHours, this.carDetailsModel,this.serviceType);

  List<DateTime> getWeekendDays() {
    List<DateTime> weekendDays = [];
    for (int i = 0; i <= daysToPick; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));
      if (date.weekday == 6 || date.weekday == 7) {
        weekendDays.add(date);
      }
    }

    return weekendDays;
  }

  static DateTime getInitalSelectedDate() {
    DateTime now = DateTime.now();
    if (now.weekday == 6) {
      return DateTime.now().add(Duration(days: 2));
    }
    if (now.weekday == 7) {
      return DateTime.now().add(Duration(days: 1));
    }
    return now;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 9.0,
              sigmaY: 9.0,
            ),
            child: Center(
              child: Container(
                height: size.height / 1.9,
                width: size.width - 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Appointment",
                      style: GoogleFonts.comfortaa(
                          fontSize: 30, color: kPrimaryColor),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Divider(
                  color: kPrimaryColor,
                  indent: 15,
                  endIndent: 15,
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: getInitalSelectedDate(),
                  selectionColor: kPrimaryColor,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      selectedDate = date;
                      print(selectedDate);
                    });
                  },
                  daysCount: daysToPick,
                  inactiveDates: getWeekendDays(),
                ),
                TimeRange(
                    fromTitle: Text(
                      'From',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    toTitle: Text(
                      'To',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    titlePadding: 20,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                    activeTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    borderColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    activeBackgroundColor: kPrimaryColor,
                    firstTime: TimeOfDay(hour: 8, minute: 00),
                    lastTime: TimeOfDay(hour: 18, minute: 00),
                    timeStep: 30,
                    timeBlock: serviceHours * 60,
                    onRangeCompleted: (range) {
                      setState(() {
                        startTime = range!.start;
                        endTime = range.end;
                        canDoAppointment = true;
                      });
                    }),
                SizedBox(height: 5,),
                Center(
                  child: SizedBox(
                      width: size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: canDoAppointment ? () {
                          DatabaseService().addAppointment(selectedDate,
                              startTime, endTime, carDetailsModel,serviceType);
                        } : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,
                                color: kPrimaryLightColor
                            ),
                            Text("Create appointment",
                              style: GoogleFonts.comfortaa(
                                  color: kPrimaryLightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
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
                          backgroundColor: MaterialStateProperty.resolveWith<
                              Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Theme
                                      .of(context)
                                      .colorScheme
                                      .primary;
                                }
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.blueGrey.shade200;
                                }
                                return kPrimaryColor;
                              }),
                        ),
                      )
                  )
                ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: kPrimaryLightColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              ),
            )));
  }
}
