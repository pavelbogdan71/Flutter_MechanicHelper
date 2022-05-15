import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

import '../../components/rounded_input_field.dart';
import '../../components/text_field_container.dart';

class EditCarDetailsScreen extends StatefulWidget {
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
  String selectedVin = '';
  String selectedKm = '';

  CarDetailsModel carDetailsModel = CarDetailsModel(
      brand: '',
      engineSize: '',
      fuel: '',
      hp: '',
      km: '',
      model: '',
      vin: '',
      year: '');

  int stepIndex = 0;
  bool isLastStep = false;

  addCarDetailsToDB() {
    CarDetailsModel carDetailsModel = CarDetailsModel(
        brand: selectedBrand,
        engineSize: selectedEngine,
        fuel: selectedFuelType,
        hp: selectedHp,
        km: selectedKm,
        model: selectedModel,
        vin: selectedVin,
        year: selectedYear);
    DatabaseService().addCarDetailsToCarList(carDetailsModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor),
              ),
              SizedBox(width: 50,),
              Text('Add a new car',style: GoogleFonts.comfortaa(
                  color: Colors.blueGrey.shade900,fontSize: 25),)
            ],
          ),
          SizedBox(height: 10),
          FutureBuilder<QuerySnapshot>(
            future: DatabaseService().getCarBrands(),
            builder: (_, snapshotCarBrands) {
              if (snapshotCarBrands.hasData) {
                List<QueryDocumentSnapshot> queryDocs =
                    snapshotCarBrands.data!.docs;
                queryDocs.forEach((QueryDocumentSnapshot element) {
                  carBrandsList.add(element.id.toString());
                });
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("car_details")
                      .doc('${FirebaseAuth.instance.currentUser.email}')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data();
                      carDetailsModel = CarDetailsModel.getCarDetails(data);

                      return Stepper(
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return Row(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  child: isLastStep
                                      ? Text(
                                    'DONE',
                                    style: GoogleFonts.comfortaa(
                                        color: Colors.blueGrey.shade50),
                                  )
                                      : Text(
                                    'NEXT',
                                    style: GoogleFonts.comfortaa(
                                        color: Colors.blueGrey.shade50),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: details.onStepCancel,
                                  child: Text(
                                    'CANCEL',
                                    style: GoogleFonts.comfortaa(
                                        color: kPrimaryColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey.shade100),
                                ),
                              ],
                            );
                          },
                          physics: ClampingScrollPhysics(),
                          currentStep: stepIndex,
                          onStepCancel: () {
                            if (stepIndex > 0) {
                              setState(() {
                                stepIndex -= 1;
                              });
                            }
                          },
                          onStepContinue: () {
                            setState(() {
                              if (isLastStep) {
                                addCarDetailsToDB();
                              }
                              if (stepIndex < 2) {
                                stepIndex += 1;
                              }
                              if (stepIndex == 2) {
                                isLastStep = true;
                              } else {
                                isLastStep = false;
                              }
                            });
                          },
                          onStepTapped: (int index) {
                            setState(() {
                              stepIndex = index;
                              if (stepIndex == 2) {
                                isLastStep = true;
                              } else {
                                isLastStep = false;
                              }
                            });
                          },
                          steps: <Step>[
                            Step(
                                title: Text(
                                  'General information',
                                  style: GoogleFonts.comfortaa(
                                      color: kPrimaryColor, fontSize: 20),
                                ),
                                content: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'Brand',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      showSelectedItems: true,
                                      items: carBrandsList,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedBrand = value!;
                                          DatabaseService().getCarModelsList(
                                              carModelsList, selectedBrand);
                                          selectedModel =
                                              carModelsList.first.toLowerCase();
                                        });
                                      },
                                      selectedItem: selectedBrand.toLowerCase(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'Model',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      items: carModelsList,
                                      showSelectedItems: true,
                                      selectedItem: selectedModel,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedModel = value!;
                                          DatabaseService().getCarEngineList(
                                              carEngineList,
                                              selectedBrand,
                                              selectedModel);
                                          selectedEngine =
                                              carEngineList.first.toLowerCase();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ])),
                            Step(
                                title: Text('Engine specs',
                                    style: GoogleFonts.comfortaa(
                                        color: kPrimaryColor, fontSize: 20)),
                                content: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'Engine',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      items: carEngineList,
                                      showSelectedItems: true,
                                      selectedItem: selectedEngine,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedEngine = value!;
                                          DatabaseService().getCarFuelTypeList(
                                              carFuelTypeList,
                                              selectedBrand,
                                              selectedModel,
                                              selectedEngine);
                                          selectedFuelType = carFuelTypeList
                                              .first
                                              .toLowerCase();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'Fuel type',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      items: carFuelTypeList,
                                      showSelectedItems: true,
                                      selectedItem: selectedFuelType,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedFuelType = value!;
                                          DatabaseService().getCarHpList(
                                              carHpList,
                                              selectedBrand,
                                              selectedModel,
                                              selectedEngine,
                                              selectedFuelType);
                                          selectedHp =
                                              carHpList.first.toLowerCase();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'HP',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      items: carHpList,
                                      showSelectedItems: true,
                                      selectedItem: selectedHp,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedHp = value!;
                                          DatabaseService().getCarYearList(
                                              carYearList,
                                              selectedBrand,
                                              selectedModel,
                                              selectedEngine,
                                              selectedFuelType,
                                              selectedHp);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ])),
                            Step(
                                title: Text('Details',
                                    style: GoogleFonts.comfortaa(
                                        color: kPrimaryColor, fontSize: 20)),
                                content: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    child: DropdownSearch(
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(40.0),
                                            borderSide: BorderSide(
                                                color:
                                                Colors.blueGrey.shade700)),
                                        filled: true,
                                        fillColor: Colors.blueGrey.shade100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        labelText: 'Year',
                                        labelStyle: GoogleFonts.comfortaa(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                      popupBackgroundColor:
                                      Colors.blueGrey.shade100,
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      mode: Mode.MENU,
                                      items: carYearList,
                                      showSelectedItems: true,
                                      selectedItem: selectedYear,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedYear = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RoundedInputField(
                                    onChanged: (value) {
                                      selectedKm = value;
                                    },
                                    hintText: 'Kilometers',
                                    icon: Icons.double_arrow_rounded,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RoundedInputField(
                                    onChanged: (value) {
                                      setState(() {
                                        selectedVin = value;
                                      });
                                    },
                                    hintText: 'VIN',
                                    icon: Icons.document_scanner,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ])),
                          ]);
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
  void initState() {
    super.initState();
  }
}
