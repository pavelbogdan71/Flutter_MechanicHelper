import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/car_detail_container.dart';
import 'package:mechanic_helper/constants.dart';
import 'package:mechanic_helper/external_libs/open_container.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/edit_car_details/edit_car_details_screen.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        heightFactor: 90,
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                ),
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Car details',
                  textScaleFactor: 2,
                  style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade200,
                      fontSize: 16,
                      textStyle: Theme.of(context).textTheme.headline1),
                ),
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                width: size.width * 0.18,
              ),
              OpenContainer(
                closedColor: Colors.blue,
                closedElevation: 0.0,
                openElevation: 4.0,
                openBuilder: (BuildContext context, VoidCallback _) =>
                    EditCarDetailsScreen(),
                closedBuilder: (BuildContext context, VoidCallback _) {
                  return Icon(
                    Icons.edit,
                    color: Colors.grey.shade200,
                  );
                },
                transitionType: ContainerTransitionType.fadeThrough,
                transitionDuration: Duration(milliseconds: 1500),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              child: Image.asset(
                "assets/images/car.png",
                width: size.width * 0.90,
                height: size.height * 0.2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3)),
                  ]),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("car_details")
                        .doc('${FirebaseAuth.instance.currentUser.email}')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.data();
                        CarDetailsModel carDetails =
                            CarDetailsModel.getCarDetails(data);

                        return Column(
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carDetails.brand,
                                    icon: Icon(
                                      Icons.directions_car_filled,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Brand"),
                                CarDetailContainer(
                                    content: carDetails.model,
                                    icon: Icon(
                                      Icons.car_rental,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Model"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carDetails.year,
                                    icon: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Year"),
                                CarDetailContainer(
                                    content: carDetails.km,
                                    icon: Icon(
                                      Icons.double_arrow_rounded,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Kilometers"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carDetails.engineSize,
                                    icon: Icon(
                                      Icons.miscellaneous_services,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Engine size"),
                                CarDetailContainer(
                                    content: carDetails.vin,
                                    icon: Icon(
                                      Icons.document_scanner,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "VIN"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carDetails.fuel,
                                    icon: Icon(
                                      Icons.local_gas_station_rounded,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "Fuel type"),
                                CarDetailContainer(
                                    content: carDetails.hp,
                                    icon: Icon(
                                      Icons.speed,
                                      color: Colors.blueGrey.shade900,
                                    ),
                                    title: "HP"),
                              ],
                            ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
