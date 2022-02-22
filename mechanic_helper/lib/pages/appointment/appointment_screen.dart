import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child:Column(
            children: [
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  return true;
                },
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      onChange: (TimeOfDay ) {  },
                      value: TimeOfDay(hour: 12, minute: 0),
                      minHour: 8,
                      maxHour: 18,
                      is24HrFormat: true
                    ),
                  );
                },
                child: Text(
                  "Open time picker",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
      ),
    );

  }

}