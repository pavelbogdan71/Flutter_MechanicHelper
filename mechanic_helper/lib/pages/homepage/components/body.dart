import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/components/service_repair_category.dart';
import 'package:mechanic_helper/constants.dart';
import 'package:mechanic_helper/pages/services/authentication_service.dart';
import 'package:provider/src/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
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
              color:Color(0xFFEEEEEE),
            ),
            height: size.height*0.45,
            width: size.width,
          ),
          SizedBox(height: 45,),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ServiceRepairCategory(
                        text: 'Oil change',
                        imagePath: "assets/images/oil_change.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Tire replacement',
                        imagePath: "assets/images/tire_replacement.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Battery replacement',
                        imagePath: "assets/images/battery_replacement.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Brake repair',
                        imagePath: "assets/images/brake_repair.png"
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ServiceRepairCategory(
                        text: 'Wheel balance',
                        imagePath: "assets/images/wheel_balance.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Gearbox service',
                        imagePath: "assets/images/gearbox_service.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Suspension service',
                        imagePath: "assets/images/suspension_service.png"
                    ),
                    ServiceRepairCategory(
                        text: 'Car check',
                        imagePath: "assets/images/car_check.png"
                    ),
                  ],
                ),
              ],
            ),
            width: size.width*0.95,
          )
        ],
      ),
    );
  }
}
