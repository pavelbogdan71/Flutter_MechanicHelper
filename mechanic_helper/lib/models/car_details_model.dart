class CarDetailsModel{
  final String brand;
  final String engineSize;
  final String fuel;
  final String hp;
  final String km;
  final String model;
  final String vin;
  final String year;

  CarDetailsModel({
    required this.brand,
    required this.engineSize,
    required this.fuel,
    required this.hp,
    required this.km,
    required this.model,
    required this.vin,
    required this.year});


  static CarDetailsModel getCarDetails(Map<String, dynamic> data){
    return CarDetailsModel(
        brand: data['brand'],
        engineSize: data['engine_size'],
        fuel: data['fuel'],
        hp: data['hp'],
        km: data['km'],
        model: data['model'],
        vin: data['vin'],
        year: data['year']
    );
  }

  static Map<String,dynamic> carDetailsToMap(CarDetailsModel carDetailsModel)=><String,dynamic>{
    'brand':carDetailsModel.brand,
    'engine_size':carDetailsModel.engineSize,
    'fuel':carDetailsModel.fuel,
    'hp':carDetailsModel.hp,
    'km':carDetailsModel.km,
    'model':carDetailsModel.model,
    'vin':carDetailsModel.vin,
    'year':carDetailsModel.year
  };
}