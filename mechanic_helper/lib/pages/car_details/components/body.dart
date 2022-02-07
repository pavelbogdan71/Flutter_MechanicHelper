import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/car_detail_container.dart';

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
          Container(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              child: Image.asset(
                "assets/images/car.png",
                width: size.width * 0.90,
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
                        var carBrand = data['brand'];
                        var carModel = data['model'];
                        var carYear = data['year'];
                        var carKm = data['km'];
                        var carVin = data['vin'];
                        var engineSize = data["engine_size"];
                        var fuelType = data["fuel"];
                        var hp = data["hp"];

                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carBrand,
                                    icon: Icon(Icons.car_rental),
                                    title: "Brand"),
                                CarDetailContainer(
                                    content: carModel,
                                    icon: Icon(Icons.car_rental),
                                    title: "Model"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: carYear.toString(),
                                    icon: Icon(Icons.car_rental),
                                    title: "Year"),
                                CarDetailContainer(
                                    content: carKm.toString(),
                                    icon: Icon(Icons.car_rental),
                                    title: "Kilometers"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: engineSize,
                                    icon: Icon(Icons.car_rental),
                                    title: "Engine size"),
                                CarDetailContainer(
                                    content: carVin,
                                    icon: Icon(Icons.car_rental),
                                    title: "VIN"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CarDetailContainer(
                                    content: fuelType,
                                    icon: Icon(Icons.car_rental),
                                    title: "Fuel type"),
                                CarDetailContainer(
                                    content: hp,
                                    icon: Icon(Icons.car_rental),
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
