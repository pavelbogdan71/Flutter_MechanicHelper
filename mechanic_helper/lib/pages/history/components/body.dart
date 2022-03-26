import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/history_service_detail_container.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/enums/appointment_status_enum.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';
import 'package:toggle_switch/toggle_switch.dart';


class Body extends StatefulWidget{
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  List<HistoryServiceDetailContainer> historyListUpcoming = [];
  List<HistoryServiceDetailContainer> historyListFinished = [];
  int menuIndex = 0;

  void sortListByDate(List<HistoryServiceDetailContainer> list){
      //list.sort((a,b)=>a.date.compareTo(b.date));
    list.sort((a, b) {
      if(a.date==b.date){
        return a.startTime.compareTo(b.startTime);
      }
      return a.date.compareTo(b.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, bottom: 30),
                child: Text(
                  'My Appointments',
                  textScaleFactor: 2,
                  style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade200,
                      fontSize: 16,
                      textStyle: Theme.of(context).textTheme.headline1),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  height: size.height * 0.80,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ToggleSwitch(
                        minWidth: 120.0,
                        initialLabelIndex: menuIndex,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['Upcoming', 'FInished'],
                        icons: [Icons.add, Icons.remove],
                        activeBgColors: [[Colors.blue],[Colors.pink]],
                        onToggle: (index) {
                          setState(() {
                            menuIndex = index!;
                          });
                          print(index);
                        },
                      ),
                      SizedBox(height: 10,),
                      StreamBuilder<DocumentSnapshot>(
                          stream: DatabaseService().getAppointments(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!.data();
                              historyListFinished.clear();
                              historyListUpcoming.clear();
                              data.forEach((key, value) {
                                if (value['client'].toString() ==
                                    '${FirebaseAuth.instance.currentUser.email}') {
                                  if(value['status'].toString()==AppointmentStatusEnum.upcoming.name){
                                    historyListUpcoming.add(HistoryServiceDetailContainer(
                                        date: value['day'],
                                        startTime: value['startTime'],
                                        endTime: value['endTime'],
                                        serviceType:
                                        value['serviceType'].toString(),
                                        carBrand: value['carDetails']['brand'],
                                        carModel: value['carDetails']['model']));
                                  }
                                  if(value['status'].toString()==AppointmentStatusEnum.finished.name){
                                    historyListFinished.add(HistoryServiceDetailContainer(
                                        date: value['day'],
                                        startTime: value['startTime'],
                                        endTime: value['endTime'],
                                        serviceType:
                                        value['serviceType'].toString(),
                                        carBrand: value['carDetails']['brand'],
                                        carModel: value['carDetails']['model']));
                                  }

                                }
                              }
                              );
                              sortListByDate(historyListUpcoming);
                              sortListByDate(historyListFinished);

                              return Expanded(
                                  child: Container(
                                  width: size.width,
                                  child: Container(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                      children: menuIndex==0?historyListUpcoming:historyListFinished,
                                    ),
                                  ),
                                ),
                              ));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          })
                    ],
                  ),
                  decoration: const BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
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
              ),
            ]),
      ),
    );
  }
}
