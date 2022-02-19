import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/service_detail_container.dart';
import 'package:mechanic_helper/components/service_repair_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_helper/external_libs/open_container.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class Body extends StatelessWidget {
  CarDetailsModel carDetailsModel = CarDetailsModel(
      brand: '',
      engineSize: '',
      fuel: '',
      hp: '',
      km: '',
      model: '',
      vin: '',
      year: '');
  String oilChangePrice = '';

  Widget getRepairPriceFromDB(CarDetailsModel carDetailsModel, String service) {
    return FutureBuilder<QuerySnapshot>(
      future: DatabaseService().getServicePrice(carDetailsModel),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.docs;
          String price = '';
          for (int i = 0; i < data.length; i++) {
            if (data[i].id == carDetailsModel.year) {
              price = data[i].data()[service]['price'];
            }
          }
          return Text('Price: ' +price + ' lei',
            style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFFECEFF1)),);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getRepairTimeInHoursFromDB(
      CarDetailsModel carDetailsModel, String service) {
    return FutureBuilder<QuerySnapshot>(
      future: DatabaseService().getServicePrice(carDetailsModel),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.docs;
          String time = '';
          for (int i = 0; i < data.length; i++) {
            if (data[i].id == carDetailsModel.year) {
              time = data[i].data()[service]['time'];
            }
          }
          return Text('Required time: '+ time + ' hours',
            style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFFECEFF1)),);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("car_details")
            .doc('${FirebaseAuth.instance.currentUser.email}')
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            carDetailsModel = CarDetailsModel.getCarDetails(data);

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/images/homepage_image.png",
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                    color: Color(0xFFEEEEEE),
                  ),
                  height: size.height * 0.45,
                  width: size.width,
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                    ServiceDetailContainer(
                              imagePath: "assets/images/oil_change.png",
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, 'oil_change'),
                              serviceType: 'Oil Change',
                              serviceTimeInHours: getRepairTimeInHoursFromDB(
                                  carDetailsModel, 'oil_change'),
                            ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: 'Oil change',
                                  imagePath: "assets/images/oil_change.png");
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Tire replacement',
                                imagePath:
                                    "assets/images/tire_replacement.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'tire_replacement'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Battery replacement',
                                imagePath:
                                    "assets/images/battery_replacement.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'battery_replacement'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                          InkWell(
                            child: ServiceRepairCategory(
                                text: 'Brake repair',
                                imagePath: "assets/images/brake_repair.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'brake_repair'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Wheel balance',
                                imagePath: "assets/images/wheel_balance.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'wheel_balance'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Gearbox service',
                                imagePath: "assets/images/gearbox_service.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'gearbox_service'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Suspension service',
                                imagePath:
                                    "assets/images/suspension_service.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'suspension_service'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                          InkWell(
                            child: const ServiceRepairCategory(
                                text: 'Car check',
                                imagePath: "assets/images/car_check.png"),
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Text('title'),
                                content: getRepairPriceFromDB(
                                    carDetailsModel, 'car_check'),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  width: size.width * 0.95,
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
