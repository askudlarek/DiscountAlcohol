import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:discount_alcohol/store.dart';
import 'package:discount_alcohol/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  test('Check Store initialization', () {
    Store store = Store("Store A", LatLng(20.0, 30.0), 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5);
    bool beerEquals = store.findAlcoholPrice("Beer") == 2.5;
    bool wineEquals = store.findAlcoholPrice("Wine") == 3.5;
    bool vodkaEquals = store.findAlcoholPrice("Vodka") == 4.5;
    bool whiskeyEquals = store.findAlcoholPrice("Whiskey") == 5.5;
    bool ginEquals = store.findAlcoholPrice("Gin") == 6.5;
    bool champagneEquals = store.findAlcoholPrice("Champagne") == 7.5;
    bool rumEquals = store.findAlcoholPrice("Rum") == 8.5;
    bool tequilaEquals = store.findAlcoholPrice("Tequila") == 9.5;
    bool good = beerEquals && wineEquals && vodkaEquals && whiskeyEquals && ginEquals && champagneEquals && rumEquals && tequilaEquals;
    expect(good, true);
  });

  test('Check alcohol not in list', () {
    Store store = Store("Store A", LatLng(20.0, 30.0), 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5);
    double fakePrice = store.findAlcoholPrice("White Claw");
    expect(fakePrice, 100000);
  });


}

