import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';

import '../../components/choose_car_container.dart';
import '../../models/car_details_model.dart';

class ChooseCarScreen extends StatelessWidget {
  List<ChooseCarContainer> carsList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kPrimaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_sharp,color: kPrimaryColor,),
                  style: ElevatedButton.styleFrom(primary: Colors.grey.shade200),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 20, bottom: 30),
              child: Text(
                'Choose a main car',
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
                  FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("car_details")
                          .doc('${FirebaseAuth.instance.currentUser.email}')
                          .collection('cars')
                          .get(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> queryDocs =
                              snapshot.data!.docs;
                          carsList.clear();
                          queryDocs.forEach((element) {
                            CarDetailsModel carDetailsModel = CarDetailsModel.getCarDetails(element.data());
                            carsList.add(ChooseCarContainer(carDetailsModel: carDetailsModel));
                          });

                          return Expanded(
                              child: Container(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: carsList,
                              ),
                            ),
                          ));
                        }
                        return const Center(child: CircularProgressIndicator());
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
            )
          ],
        ),
      ),
    );
  }
}
