import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/components/history_service_detail_container.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: DatabaseService().getAppointments(),
                  builder: (_, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!.data();
                      List<HistoryServiceDetailContainer> historyList = [];
                      data.forEach((key, value) {
                        if (value['client'].toString() == '${FirebaseAuth.instance.currentUser.email}') {
                          historyList.add(HistoryServiceDetailContainer(
                              date: value['day'],
                              startTime: value['startTime'],
                              endTime: value['endTime'],
                              serviceType: value['serviceType'].toString(),
                              carBrand: value['carDetails']['brand'],
                              carModel: value['carDetails']['model']));
                        }
                      });
                      return Column(
                        children: historyList,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());

                  })
            ]),
      ),
    );
  }
}
