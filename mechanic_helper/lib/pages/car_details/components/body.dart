import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("car_details").doc('${FirebaseAuth.instance.currentUser.email}').snapshots(),
                    builder: (_,snapshot){
                      if(snapshot.hasData){
                        var data = snapshot.data!.data();
                        var carBrand = data['brand'];
                        var carModel = data['model'];
                        return Row(
                          children: [
                            Text(carBrand+" "),
                            Text(carModel)
                          ],
                        );
                      }
                      return Center(child:CircularProgressIndicator());
                    },
                  ),
                ],
              ),

            ]),
      ),
    );
  }
}