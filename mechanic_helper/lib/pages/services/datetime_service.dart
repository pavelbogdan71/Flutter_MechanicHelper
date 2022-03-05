import 'package:flutter/material.dart';

class DateTimeService{

  static String twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  static String timeOfDayToString(TimeOfDay timeOfDay){
    return twoDigits(timeOfDay.hour)+':'+twoDigits(timeOfDay.minute);
  }

  static String dateTimeToString(DateTime dateTime){
    return dateTime.year.toString()+'-'+ twoDigits(dateTime.month)+'-'+twoDigits(dateTime.day)+' '+twoDigits(dateTime.hour)+':'+twoDigits(dateTime.minute)+':'+ twoDigits(dateTime.second)+'-'+dateTime.millisecond.toString()+dateTime.microsecond.toString();
  }

}