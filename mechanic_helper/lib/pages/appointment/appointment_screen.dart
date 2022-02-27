import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:time_range/time_range.dart';


class AppointmentScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => AppointmentScreenState();

}

class AppointmentScreenState extends State<AppointmentScreen> {

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: kPrimaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              TimeRange(
                fromTitle: Text('From', style: TextStyle(fontSize: 18, color: Colors.grey),),
                toTitle: Text('To', style: TextStyle(fontSize: 18, color: Colors.grey),),
                titlePadding: 20,
                textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                borderColor: Colors.black,
                backgroundColor: Colors.transparent,
                activeBackgroundColor: kPrimaryColor,
                firstTime: TimeOfDay(hour: 8, minute: 00),
                lastTime: TimeOfDay(hour: 18, minute: 00),
                timeStep: 30,
                timeBlock: 30,
                onRangeCompleted: (range){
                  setState(() {
                    startTime = range!.start;
                    endTime = range.end;
                  });
                }
              ),
            ],
          )),
    );
  }
}
