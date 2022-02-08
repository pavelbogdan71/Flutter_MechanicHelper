import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_helper/models/car_details_model.dart';

class DatabaseService{

  CollectionReference carDetails = FirebaseFirestore.instance.collection('car_details');



  Future<void> addCarDetails(CarDetailsModel carDetailsModel){
    return carDetails
    .doc('${FirebaseAuth.instance.currentUser.email}')
        .set(CarDetailsModel.carDetailsToMap(carDetailsModel),SetOptions(merge:true));
  }
}