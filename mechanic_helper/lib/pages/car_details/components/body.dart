import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/components/car_detail_container.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        heightFactor: 90,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Car details',
              textScaleFactor: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            child: ClipRRect(
              child: Image.asset(
                "assets/images/car.png",
                width: size.width * 0.90,
              ),
            ),
          ),
          Container(
            height: size.height*0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              ),
            ),
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

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CarDetailContainer(
                                  child: Text(carBrand),
                                  icon: Icon(Icons.car_rental),
                                  title: "Brand"
                              ),
                              CarDetailContainer(
                                  child: Text(carModel),
                                  icon: Icon(Icons.car_rental),
                                  title: "Model"
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CarDetailContainer(
                                  child: Text(carYear.toString()),
                                  icon: Icon(Icons.car_rental),
                                  title: "Year of manufacter"
                              ),
                              CarDetailContainer(
                                  child: Text(carKm.toString()),
                                  icon: Icon(Icons.car_rental),
                                  title: "Kilometers"
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),

        ]),
      ),
    );
  }
}
