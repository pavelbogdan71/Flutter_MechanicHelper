import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/datetime_service.dart';

class DatabaseService {
  CollectionReference carDetails = FirebaseFirestore.instance.collection('car_details');
  CollectionReference carBrandsRef = FirebaseFirestore.instance.collection('cars');

  Future<void> addCarDetails(CarDetailsModel carDetailsModel) {
    return carDetails.doc('${FirebaseAuth.instance.currentUser.email}').set(
        CarDetailsModel.carDetailsToMap(carDetailsModel),
        SetOptions(merge: true));
  }

  Future<void>addAppointment(DateTime selectedTime,TimeOfDay startTime,TimeOfDay endTime,CarDetailsModel carDetailsModel,String serviceType){

    return FirebaseFirestore.instance.collection('appointments').doc('mechanic1').update(
        {
          DateTimeService.dateTimeToString(DateTime.now()): <String,dynamic>{
            'startTime': DateTimeService.timeOfDayToString(startTime),
            'endTime':DateTimeService.timeOfDayToString(endTime),
            'client':'${FirebaseAuth.instance.currentUser.email}',
            'day':selectedTime.year.toString()+'-'+DateTimeService.twoDigits(selectedTime.month)+'-'+DateTimeService.twoDigits(selectedTime.day),
            'carDetails':CarDetailsModel.carDetailsToMap(carDetailsModel),
            'serviceType':serviceType
          }
        });
  }

  Stream<DocumentSnapshot> getAppointments(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection('appointments').doc('mechanic1');

    return documentReference.snapshots();
  }

  Future<QuerySnapshot> getCarBrands() async {
    return await carBrandsRef.get();
  }

  Future<QuerySnapshot> getCarModels(String selectedBrand) async{
    return await FirebaseFirestore.instance.collection('cars').doc(selectedBrand.toLowerCase()).collection('models').get();
  }

  Future<void> getCarModelsList(List<String> list,String selectedBrand) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cars').doc(selectedBrand.toLowerCase()).collection('models').get();
    final data = querySnapshot.docs.map((e) => e.id).toList();
    list.clear();
    data.forEach((element) {
      list.add(element.toString());
    });
  }

  Future<QuerySnapshot> getServicePrice(CarDetailsModel carDetailsModel) async{
    return await FirebaseFirestore.instance.collection('cars/'+carDetailsModel.brand.toLowerCase()+'/models/'+carDetailsModel.model.toLowerCase()+'/engine/'+carDetailsModel.engineSize+'/fuel/'+carDetailsModel.fuel.toLowerCase()+'/hp/'+carDetailsModel.hp+'/year').get();
  }
}
