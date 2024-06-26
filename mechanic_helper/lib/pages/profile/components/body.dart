import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/pages/services/authentication_service.dart';
import 'package:provider/src/provider.dart';

import '../../services/database_service.dart';

class Body extends StatelessWidget {

  int numberOfAppointments = 0;
  int numberOfCars = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey.shade50),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Profile',
                    style: GoogleFonts.comfortaa(
                        color: Colors.blueGrey.shade900,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        textStyle: Theme.of(context).textTheme.headline1),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.9,
                    height: size.height * 0.21,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.shade800,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(3, 2)),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_circle,
                            size: 120,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text('${FirebaseAuth.instance.currentUser.email}',
                                style: GoogleFonts.comfortaa(
                                    color: Colors.blueGrey.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    textStyle:
                                        Theme.of(context).textTheme.headline1))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.9,
                    height: size.height * 0.45,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 30,),
                                  Text('Number of cars: ',
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.blueGrey.shade900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline1)),
                                ],
                              ),
                              Divider(thickness: 3,endIndent: 100,indent: 30,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(width: 50,),
                                  Icon(Icons.directions_car_filled_rounded),
                                  FutureBuilder<QuerySnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection("car_details")
                                        .doc('${FirebaseAuth.instance.currentUser.email}')
                                        .collection('cars')
                                        .get(),
                                    builder: (_, snapshot) {
                                      if(snapshot.hasData) {
                                        List<QueryDocumentSnapshot> queryDocs =
                                            snapshot.data!.docs;
                                        numberOfCars = queryDocs.length;

                                        return Text(' ' + numberOfCars.toString() + ' cars',
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.blueGrey.shade900,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline1));
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 30,),
                                  Text('Number of appointments: ',
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.blueGrey.shade900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline1)),
                                ],
                              ),
                              Divider(thickness: 3,endIndent: 30,indent: 30,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(width: 50,),
                                  Icon(Icons.calendar_today_rounded),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: DatabaseService().getAppointments(),
                                    builder:  (_, snapshot) {
                                      if(snapshot.hasData) {
                                        var data = snapshot.data!.data();
                                        data.forEach((key, value) {
                                          if (value['client'].toString() ==
                                              '${FirebaseAuth.instance.currentUser.email}'){
                                            numberOfAppointments++;
                                          }
                                        });

                                        return Text(' ' + numberOfAppointments.toString() + ' appointments',
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.blueGrey.shade900,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline1));
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height:100),
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<AuthenticationService>().signOut();
                              },
                              icon: Icon(Icons.logout),
                              label: Text("Logout"),
                              style: ElevatedButton.styleFrom(primary: Colors.grey.shade900),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),

            ]),
      ),
    );
  }
}
