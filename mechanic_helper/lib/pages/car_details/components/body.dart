import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/car_detail_container.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/external_libs/open_container.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/edit_car_details/edit_car_details_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Body extends StatefulWidget{
  @override
  BodyState createState() =>BodyState();
}

class BodyState extends State<Body> {
  TextEditingController brandController = new TextEditingController();

  List<CarDetailsModel> carDetailsModelList = [];

  List<List<Color>> activeBgColors = [];

  int menuIndex = 0;
  int listSize = 0;

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
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200
                    ),
                    child: Icon(
                      Icons.add,
                      color: kPrimaryColor,
                    ),
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
                height: size.height * 0.13,
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
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("car_details")
                        .doc('${FirebaseAuth.instance.currentUser.email}').collection('cars')
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<QueryDocumentSnapshot> queryDocs = snapshot.data!.docs;
                        carDetailsModelList.clear();
                        activeBgColors.clear();
                        var i=0;
                        queryDocs.forEach((element) {
                          activeBgColors.add(i%2==0?[Colors.blue]:[Colors.green]);
                          carDetailsModelList.add(CarDetailsModel.getCarDetails(element.data()));
                          i++;
                        });

                        if(carDetailsModelList.length==0){
                          return Container(
                            child: Row(
                              children: [
                                Text("You dont have a car added"),
                                OpenContainer(
                                  closedColor: Colors.blue,
                                  closedElevation: 0.0,
                                  openElevation: 4.0,
                                  openBuilder: (BuildContext context, VoidCallback _) =>
                                      EditCarDetailsScreen(),
                                  closedBuilder: (BuildContext context, VoidCallback _) {
                                    return Icon(
                                      Icons.add,
                                      color: Colors.grey.shade200,
                                    );
                                  },
                                  transitionType: ContainerTransitionType.fadeThrough,
                                  transitionDuration: Duration(milliseconds: 1500),
                                ),
                              ],
                            ),
                          );
                        }

                        if(carDetailsModelList.isNotEmpty){
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ToggleSwitch(
                                    minWidth: 150.0,
                                    initialLabelIndex: menuIndex,
                                    cornerRadius: 20.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey,
                                    inactiveFgColor: Colors.white,
                                    totalSwitches: carDetailsModelList.length,
                                    labels: carDetailsModelList.map((e) => e.brand.toUpperCase()+' '+e.model.toUpperCase()).toList(),
                                    activeBgColors: activeBgColors,
                                    onToggle: (index) {
                                      setState(() {
                                        menuIndex = index!;
                                      });
                                    },
                                  ),
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CarDetailContainer(
                                      content: carDetailsModelList[menuIndex].brand,
                                      icon: Icon(
                                        Icons.directions_car_filled,
                                        color: Colors.blueGrey.shade900,
                                      ),
                                      title: "Brand"),
                                  CarDetailContainer(
                                      content: carDetailsModelList[menuIndex].model,
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
                                      content: carDetailsModelList[menuIndex].year,
                                      icon: Icon(
                                        Icons.calendar_today_rounded,
                                        color: Colors.blueGrey.shade900,
                                      ),
                                      title: "Year"),
                                  CarDetailContainer(
                                      content: carDetailsModelList[menuIndex].km,
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
                                      content: carDetailsModelList[menuIndex].engineSize,
                                      icon: Icon(
                                        Icons.miscellaneous_services,
                                        color: Colors.blueGrey.shade900,
                                      ),
                                      title: "Engine size"),
                                  CarDetailContainer(
                                      content: carDetailsModelList[menuIndex].vin,
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
                                      content: carDetailsModelList[menuIndex].fuel,
                                      icon: Icon(
                                        Icons.local_gas_station_rounded,
                                        color: Colors.blueGrey.shade900,
                                      ),
                                      title: "Fuel type"),
                                  CarDetailContainer(
                                      content: carDetailsModelList[menuIndex].hp,
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
