import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_helper/models/car_details_model.dart';

class DatabaseService {
  CollectionReference carDetails =
  FirebaseFirestore.instance.collection('car_details');
  CollectionReference carBrandsRef = FirebaseFirestore.instance.collection('cars');

  Future<void> addCarDetails(CarDetailsModel carDetailsModel) {
    return carDetails.doc('${FirebaseAuth.instance.currentUser.email}').set(
        CarDetailsModel.carDetailsToMap(carDetailsModel),
        SetOptions(merge: true));
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

  Future<void> getServicePrice(CarDetailsModel carDetailsModel,String service,String priceVar) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cars/'+carDetailsModel.brand.toLowerCase()+'/models/'+carDetailsModel.model.toLowerCase()+'/engine/'+carDetailsModel.engineSize+'/fuel/'+carDetailsModel.fuel.toLowerCase()+'/hp/'+carDetailsModel.hp+'/year').get();

    final data = querySnapshot.docs;
    for(int i=0;i<data.length;i++){
      if(data[i].id==carDetailsModel.year){
        priceVar = data[i].data()[service];
      }
    }
    print(data);
  }
}
