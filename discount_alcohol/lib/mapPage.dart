import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'store.dart';
import 'dart:math' show cos, sqrt, asin;

// widget to render the page for Google map lookups
class MapPageFrame extends StatelessWidget {

  @override
  MapPageFrame(this.initialSearchDrink);

  // this string is passed all the way down to MapPageState
  // to populate initial value of the search field
  // assigned on construction by homepage onTap() event
  final String initialSearchDrink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // prevents Google Maps from resizing when keyboard is open
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("DiscountAlcohol"),
      ),
      body: MapPage(initialSearchDrink),
    );
  }
}

class MapPage extends StatefulWidget {

  MapPage(this._drinkSearch);

  final String _drinkSearch;

  @override
  MapPageState createState() => MapPageState(_drinkSearch);
}

class MapPageState extends State<MapPage> {

  GoogleMapController mapController;

  final LatLng _center = const LatLng(39.728786, -121.837580);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    readData();
    filterSearch();
  }

  // Filter the search based on the users restrictions
  void filterSearch() {
    _markers = {};
    for (var i = 0; i < markerList.length; i++) {
      var store = markerList[i];
      if (_maxPrice >= store.findAlcoholPrice(_drinkSearch) &&
          calculateDistance(_center.latitude, _center.longitude, store.location.latitude, store.location.longitude) <= _searchRadius) {
        _addMarker(i.toString(), store, _drinkSearch);
      }
    }
  }

  // Calculate the distance between two given latlng points in miles
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p))/2;
    var km = 12742 * asin(sqrt(a));
    return km / 1.609344;
  }


  // CHANGE ALL OF THE BELOW TO ACCOUNT FOR PULLING IN DATA
  var markerList = new List();

  // This is where we will read the data in from the
  void readData() {
    var store = new Store("Testing1", LatLng(39.728780, -121.837585), 4.25, 4.13, 5.42, 7.65, 8.54, 23.54, 10.11, 9.95);
    var store1 = new Store("Testing2", LatLng(39.738780, -121.837485), 4.25, 4.13, 5.42, 7.65, 8.54, 23.54, 10.11, 9.95);
    var store2 = new Store("Testing3", LatLng(39.829780, -121.937565), 4.25, 4.13, 5.42, 7.65, 8.54, 10.00, 10.00, 9.95);
    markerList.add(store);
    markerList.add(store1);
    markerList.add(store2);
  }
  // CHANGE ALL OF THE ABOVE TO ACCOUNT FOR PULLING IN DATA

  Set<Marker> _markers = {};
  // Add a marker to the map
  void _addMarker(String id, Store store, String key) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(id),
        position: store.location,
        infoWindow: InfoWindow(
          title: store.name,
          snippet: '\$'+store.findAlcoholPrice(key).toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  MapPageState(this._drinkSearch);

  // state variables for this page
  String _drinkSearch;    // form: type of drink to search for (e.g. beer)
  int _searchRadius = 1;  // filter
  int _maxPrice = 10;     // filter



  // helper function for generating dropdown menu
  List<DropdownMenuItem<int>> getDistanceDropdownItems() {
    return [
      DropdownMenuItem<int>(value: 1, child: Text("1 mi")),
      DropdownMenuItem<int>(value: 3, child: Text("3 mi")),
      DropdownMenuItem<int>(value: 5, child: Text("5 mi")),
      DropdownMenuItem<int>(value: 10, child: Text("10 mi")),
      DropdownMenuItem<int>(value: 20, child: Text("20 mi")),
      DropdownMenuItem<int>(value: 50, child: Text("50 mi")),
    ];
  }

  Widget build(BuildContext context) {
    // a column containing the filter (as a form) and the google maps view
    return Column(
      children: <Widget>[
        // the filter/search form, should contain all necessary fields within
        Form(
          child: Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange, width: 4.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                // the beverage to search for
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Drink: ",
                    contentPadding: EdgeInsets.fromLTRB(24, 6, 24, 6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                      )
                    ),
                  ),
                  initialValue: _drinkSearch,
                  onChanged: (String newValue) => setState(() {
                    _drinkSearch = newValue;
                    filterSearch();
                  }),
                ),
                // this Row here allows the next Widgets to be on the same horizontal line
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // the field for filtering by distance
                    Text("Within:  "),
                    Container(
                      width: 100,
                      child: DropdownButtonFormField<int>(
                        value: _searchRadius,
                        hint: Text("Distance"),
                        items: getDistanceDropdownItems(),
                        onChanged: (int newValue) {
                          _searchRadius = newValue;
                          setState((){});
                          filterSearch();
                        }
                      ),
                    ),
                    // the field for filtering by price
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Max Price: ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              borderSide: BorderSide(
                                width: 2.0,
                              )
                            )
                          ),
                          initialValue: _maxPrice.toString(),
                          onChanged: (String newValue) => setState(() {
                            _maxPrice = int.parse(newValue);
                            filterSearch();
                          }),
                          keyboardType: TextInputType.number,
                        )
                      )
                    )
                  ]
                )
              ]
            )
          )
        ),
          Flexible(
              child: Center(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
            )
          )
      ]
    );
  }
}
