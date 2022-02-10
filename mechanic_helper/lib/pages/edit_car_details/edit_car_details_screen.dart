import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class EditCarDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ],
          ),
          SizedBox(height: 10),
          FutureBuilder<QuerySnapshot>(
            future: DatabaseService().getCarBrands(),
            builder: (_, snapshotCarBrands) {
              if (snapshotCarBrands.hasData) {
                List<QueryDocumentSnapshot> list = snapshotCarBrands.data!.docs;
                List<String> carBrandsList = [];
                list.forEach((QueryDocumentSnapshot element) {
                  carBrandsList.add(element.id.toString());
                });
                print(list);
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("car_details")
                      .doc('${FirebaseAuth.instance.currentUser.email}')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data();
                      CarDetailsModel carDetails =
                          CarDetailsModel.getCarDetails(data);
                      String selectedBrand = carDetails.brand;
                      return Column(
                        children: [
                          DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItems: true,
                              items: carBrandsList,
                              label: "Brand",
                              hint: "Car brand",
                              popupItemDisabled: (String s) =>
                                  s.startsWith('I'),
                              onChanged: (String? str){
                                selectedBrand = str!;
                              },
                              selectedItem: selectedBrand,
                          ),
                          SizedBox(height: 10,),
                          FutureBuilder<QuerySnapshot>(
                            future:DatabaseService().getCarModels(selectedBrand),
                            builder: (_,carModelsSnapshot){
                              if(carModelsSnapshot.hasData){
                                List<String> list =[];
                                List<QueryDocumentSnapshot> querySnapshotList = carModelsSnapshot.data!.docs;
                                querySnapshotList.forEach((element) {
                                  list.add(element.id.toString());
                                });
                                return DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: list,
                                  selectedItem: list.first,
                                  label: "Model",
                                );
                              }
                              return const Center(child: CircularProgressIndicator());

                            },
                          ),

                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
