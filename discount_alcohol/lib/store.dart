import 'package:google_maps_flutter/google_maps_flutter.dart';
// Store class to hold the store information for filtering
class Store {
  Store(this.name, this.location,
        double beer, double wine, double vodka,
        double whiskey, double gin, double champagne,
        double rum, double tequila) {
    alcohol['Beer'] = beer;
    alcohol['Wine'] = wine;
    alcohol['Vodka'] = vodka;
    alcohol['Whiskey'] = whiskey;
    alcohol['Gin'] = gin;
    alcohol['Champagne'] = champagne;
    alcohol['Rum'] = rum;
    alcohol['Tequila'] = tequila;
  }

  String name;
  LatLng location;
  var alcohol = {};

  double findAlcoholPrice(String key) {
    if (alcohol.containsKey(key)){
      return alcohol[key];
    } else {
      return 100000;
    }
  }
}