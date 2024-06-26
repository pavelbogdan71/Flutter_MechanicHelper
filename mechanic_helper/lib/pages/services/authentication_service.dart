import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/models/car_details_model.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String? email,String? password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String> signUp({String? email,String? password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      CarDetailsModel carDetailsModel = CarDetailsModel(brand: "", engineSize: "", fuel: "", hp: "", km: "", model: "", vin: "", year: "");
      DatabaseService().addCarDetails(carDetailsModel);
      return "Signed up";
    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }

}