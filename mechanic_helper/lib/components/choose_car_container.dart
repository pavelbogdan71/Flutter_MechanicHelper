import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';
import 'package:mechanic_helper/extensions/string_extension.dart';

class ChooseCarContainer extends StatelessWidget {
  final CarDetailsModel carDetailsModel;
  CarDetailsModel? selectedCarDetails;

  ChooseCarContainer({Key? key, required this.carDetailsModel})
      : super(key: key);

  final Icon checkIcon = Icon(Icons.check_circle_outline, color: Colors.green);
  final Icon notCheckIcon = Icon(Icons.dangerous_outlined, color: Colors.red,);
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {
            DatabaseService().addCarDetails(carDetailsModel);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("car_details")
                  .doc('${FirebaseAuth.instance.currentUser.email}')
                  .snapshots(),
              builder: (_,snapshot){
                if(snapshot.hasData){
                  var data = snapshot.data!.data();
                  selectedCarDetails = CarDetailsModel.getCarDetails(data);

                  if(selectedCarDetails?.brand==carDetailsModel.brand && carDetailsModel.model ==selectedCarDetails?.model){
                    isChecked = true;
                  }
                  else{
                    isChecked = false;
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.directions_car_filled,color: Colors.blueGrey.shade900),
                          SizedBox(width: 5,),
                          Text(
                              carDetailsModel.brand.capitalize() +
                                  ' ' +
                                  carDetailsModel.model.capitalize(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  textStyle: Theme.of(context).textTheme.headline1)),
                          SizedBox(width: 20,),
                          isChecked?checkIcon:notCheckIcon
                        ],
                      ),
                      const Divider(
                        color: Color(0xFF546E7A),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.blueGrey.shade900,
                                ),
                                Text(carDetailsModel.year,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        textStyle: Theme.of(context).textTheme.headline1)),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.miscellaneous_services,
                                  color: Colors.blueGrey.shade900,
                                ),
                                Text(carDetailsModel.engineSize + ' l',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        textStyle: Theme.of(context).textTheme.headline1))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_gas_station_rounded,
                                  color: Colors.blueGrey.shade900,
                                ),
                                Text(carDetailsModel.fuel.capitalize(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        textStyle: Theme.of(context).textTheme.headline1)),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.speed,
                                  color: Colors.blueGrey.shade900,
                                ),
                                Text(carDetailsModel.hp+' hp',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        textStyle: Theme.of(context).textTheme.headline1)),
                              ],
                            ),
                          )

                        ],
                      )
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            height: size.height * 0.18,
            width: size.width * 0.7,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFECEFF1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF546E7A),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(4, 5),
                  )
                ]),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
