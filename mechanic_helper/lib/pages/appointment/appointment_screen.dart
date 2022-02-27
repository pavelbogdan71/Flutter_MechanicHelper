import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

import '../../external_libs/time_range.dart';


class AppointmentScreen extends StatefulWidget{
  final int serviceHours;

  const AppointmentScreen({Key? key, required this.serviceHours}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppointmentScreenState(serviceHours);

}

class AppointmentScreenState extends State<AppointmentScreen> {

  final int serviceHours;

  DateTime selectedDate = getInitalSelectedDate();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  int daysToPick = 30;

  AppointmentScreenState(this.serviceHours);

  List<DateTime> getWeekendDays(){
    List<DateTime> weekendDays=[];
    for(int i=0;i<=daysToPick;i++){
      DateTime date = DateTime.now().add(Duration(days: i));
      if(date.weekday==6 || date.weekday==7){
        weekendDays.add(date);
      }
    }

    return weekendDays;
  }

  static DateTime getInitalSelectedDate(){
    DateTime now = DateTime.now();
    if(now.weekday==6){
      return DateTime.now().add(Duration(days: 2));
    }
    if(now.weekday==7){
      return DateTime.now().add(Duration(days: 1));
    }
    return now;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
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
                inactiveDates:getWeekendDays(),
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
                timeBlock: serviceHours*60,
                onRangeCompleted: (range){
                  setState(() {
                    startTime = range!.start;
                    endTime = range.end;
                  });
                }
              ),
              ElevatedButton(
                  onPressed: (){
                    DatabaseService().addAppointment(selectedDate,startTime,endTime);
                  },
                  child: Icon(Icons.add))
            ],
          )),
    );
  }
}
