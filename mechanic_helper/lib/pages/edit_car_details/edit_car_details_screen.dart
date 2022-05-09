import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

import '../../components/rounded_input_field.dart';


class EditCarDetailsScreen extends StatefulWidget{

  EditCarDetailsScreen();

  @override
  State<StatefulWidget> createState() => EditCarDetailsScreenState();

}

class EditCarDetailsScreenState extends State<EditCarDetailsScreen> {

  List<String> carModelsList = [];
  List<String> carBrandsList = [];
  List<String> carEngineList = [];
  List<String> carFuelTypeList = [];
  List<String> carHpList = [];
  List<String> carYearList = [];

  String selectedBrand = '';
  String selectedModel = '';
  String selectedEngine = '';
  String selectedFuelType = '';
  String selectedHp = '';
  String selectedYear = '';

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
                      return Column(
                        children: [
                          DropdownSearch(
                            mode:Mode.MENU,
                            showSelectedItems: true,
                            items:carBrandsList,
                            label:'Brand',
                            onChanged: (String? value){
                              setState(() {
                                selectedBrand = value!;
                                DatabaseService().getCarModelsList(carModelsList, selectedBrand);
                                selectedModel = carModelsList.first.toLowerCase();
                              });
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
                              setState(() {
                                selectedModel = value!;
                                DatabaseService().getCarEngineList(carEngineList, selectedBrand, selectedModel);
                                selectedEngine = carEngineList.first.toLowerCase();
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          DropdownSearch(
                            mode:Mode.MENU,
                            items: carEngineList,
                            label:'Engine',
                            showSelectedItems: true,
                            selectedItem: selectedEngine,
                            onChanged: (String? value){
                              setState(() {
                                selectedEngine = value!;
                                DatabaseService().getCarFuelTypeList(carFuelTypeList, selectedBrand, selectedModel, selectedEngine);
                                selectedFuelType = carFuelTypeList.first.toLowerCase();
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          DropdownSearch(
                            mode:Mode.MENU,
                            items: carFuelTypeList,
                            label:'Fuel type',
                            showSelectedItems: true,
                            selectedItem: selectedFuelType,
                            onChanged: (String? value){
                              setState(() {
                                selectedFuelType = value!;
                                DatabaseService().getCarHpList(carHpList, selectedBrand, selectedModel, selectedEngine, selectedFuelType);
                                selectedHp = carHpList.first.toLowerCase();
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          DropdownSearch(
                            mode:Mode.MENU,
                            items: carHpList,
                            label:'Hp',
                            showSelectedItems: true,
                            selectedItem: selectedHp,
                            onChanged: (String? value){
                              setState(() {
                                selectedHp = value!;
                                DatabaseService().getCarYearList(carYearList, selectedBrand, selectedModel, selectedEngine, selectedFuelType, selectedHp);
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          DropdownSearch(
                            mode:Mode.MENU,
                            items: carYearList,
                            label:'Year',
                            showSelectedItems: true,
                            selectedItem: selectedYear,
                            onChanged: (String? value){
                              selectedYear = value!;
                            },
                          ),
                          SizedBox(height: 10,),
                          Text("Kilometers"),
                          TextFormField(

                          ),
                          SizedBox(height: 10,),
                          Text("VIN"),
                          TextFormField(

                          )
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
