import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';


class EditCarDetailsScreen extends StatefulWidget{

  EditCarDetailsScreen();

  @override
  State<StatefulWidget> createState() => EditCarDetailsScreenState();

}

class EditCarDetailsScreenState extends State<EditCarDetailsScreen> {

  List<String> carModelsList = [];
  List<String> carBrandsList = [];
  String selectedBrand = '';
  String selectedModel = '';
  CarDetailsModel carDetailsModel = CarDetailsModel(brand: '', engineSize: '', fuel: '', hp: '', km: '', model: '', vin: '', year: '');

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
            builder: (_, snapshotCarBrands){
              if(snapshotCarBrands.hasData){
                List<QueryDocumentSnapshot> queryDocs = snapshotCarBrands.data!.docs;
                queryDocs.forEach((QueryDocumentSnapshot element) {
                  carBrandsList.add(element.id.toString());
                });
                return StreamBuilder<DocumentSnapshot>(
                  stream:FirebaseFirestore.instance
                      .collection("car_details")
                      .doc('${FirebaseAuth.instance.currentUser.email}')
                      .snapshots(),
                  builder: (_,snapshot){
                    if(snapshot.hasData){
                      var data = snapshot.data!.data();
                      carDetailsModel = CarDetailsModel.getCarDetails(data);
                      selectedBrand = carDetailsModel.brand;
                      selectedModel = carDetailsModel.model;
                      return Column(
                        children: [
                          DropdownSearch(
                            mode:Mode.MENU,
                            showSelectedItems: true,
                            items:carBrandsList,
                            label:'Brand',
                            onChanged: (String? value){
                              selectedBrand = value!;
                              DatabaseService().getCarModelsList(carModelsList, selectedBrand);
                              selectedModel = carModelsList.first.toLowerCase();
                            },
                            selectedItem: selectedBrand.toLowerCase(),
                          ),
                          SizedBox(height: 10,),
                          DropdownSearch(
                            mode:Mode.MENU,
                            items: carModelsList,
                            label:'Model',
                            showSelectedItems: true,
                            selectedItem: selectedModel,
                            onChanged: (String? value){
                              selectedModel = value!;
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




  @override
  void initState(){
    super.initState();
  }
}
