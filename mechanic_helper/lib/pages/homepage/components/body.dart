import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/service_detail_container.dart';
import 'package:mechanic_helper/components/service_repair_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_helper/constants/strings.dart';
import 'package:mechanic_helper/external_libs/open_container.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>BodyState();
}

class BodyState extends State<Body> {
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
  int timeForRepair = 0;

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
          return Text(
            'Price: ' + price + ' lei',
            style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFFECEFF1)),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getWidgetRepairTimeInHoursFromDB(
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
            timeForRepair = int.parse(time);
          return Text(
            'Required time: ' + time + ' hours',
            style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFFECEFF1)),
          );
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
                              imagePath: oilChangeImagePath,
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, oilChange),
                              serviceType: oilChangeDetailsTitle,
                              serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                  carDetailsModel, oilChange),
                                      description: oilChangeDescription,
                                      timeForRepair: timeForRepair,
                            ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: oilChangeDetailsTitle,
                                  imagePath: oilChangeHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                    ServiceDetailContainer(
                              imagePath: tireReplacementImagePath,
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, tireReplacement),
                              serviceType: tireReplacementDetailsTitle,
                              serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                  carDetailsModel, tireReplacement),
                                      description: tireReplacementDescription,
                                      timeForRepair: timeForRepair,

                                    ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: tireReplacementDetailsTitle,
                                  imagePath: tireReplacementHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                    ServiceDetailContainer(
                              imagePath: batteryReplacementImagePath,
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, batteryReplacement),
                              serviceType: batteryReplacementDetailsTitle,
                              serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                  carDetailsModel, batteryReplacement),
                                      description: batteryReplacementDescription,
                                      timeForRepair: timeForRepair,

                                    ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: batteryReplacementDetailsTitle,
                                  imagePath:
                                      batteryReplacementHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                    ServiceDetailContainer(
                              imagePath: brakeRepairImagePath,
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, brakeRepair),
                              serviceType: brakeRepairDetailsTitle,
                              serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                  carDetailsModel, brakeRepair),
                                      description: brakeRepairDescription,
                                      timeForRepair: timeForRepair,

                                    ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: brakeRepairDetailsTitle,
                                  imagePath: brakeRepairHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              imagePath: wheelBalanceImagePath,
                              priceWidget: getRepairPriceFromDB(
                                  carDetailsModel, wheelBalance),
                              serviceType: wheelBalanceDetailsTitle,
                              serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                  carDetailsModel, wheelBalance),
                                      description: wheelBalanceDescription,
                                      timeForRepair: timeForRepair,

                                    ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: wheelBalanceDetailsTitle,
                                  imagePath: wheelBalanceHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                ServiceDetailContainer(
                                  imagePath: gearboxServiceImagePath,
                                  priceWidget: getRepairPriceFromDB(
                                      carDetailsModel, gearboxService),
                                  serviceType: gearboxServiceDetailsTitle,
                                  serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                      carDetailsModel, gearboxService),
                                  description: gearboxServiceDescription,
                                  timeForRepair: timeForRepair,

                                ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: gearboxServiceDetailsTitle,
                                  imagePath: gearboxServiceHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                ServiceDetailContainer(
                                  imagePath: suspensionServiceImagePath,
                                  priceWidget: getRepairPriceFromDB(
                                      carDetailsModel, suspensionService),
                                  serviceType: suspensionServiceDetailsTitle,
                                  serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                      carDetailsModel, suspensionService),
                                  description: suspensionServiceDescription,
                                  timeForRepair: timeForRepair,

                                ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: suspensionServiceDetailsTitle,
                                  imagePath: suspensionServiceHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
                          ),
                          OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0.0,
                            openElevation: 4.0,
                            openBuilder:
                                (BuildContext context, VoidCallback _) =>
                                ServiceDetailContainer(
                                  imagePath: carCheckImagePath,
                                  priceWidget: getRepairPriceFromDB(
                                      carDetailsModel, carCheck),
                                  serviceType: carCheckDetailsTitle,
                                  serviceTimeInHours: getWidgetRepairTimeInHoursFromDB(
                                      carDetailsModel, carCheck),
                                  description: carCheckDescription,
                                  timeForRepair: timeForRepair,

                                ),
                            closedBuilder:
                                (BuildContext context, VoidCallback _) {
                              return const ServiceRepairCategory(
                                  text: carCheckDetailsTitle,
                                  imagePath: carCheckHomepageImagePath);
                            },
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: Duration(milliseconds: 1500),
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
