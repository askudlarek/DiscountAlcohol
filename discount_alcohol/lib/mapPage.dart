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
    var store = new Store("Fifth & Ivy Liquor", LatLng(39.724516, -121.843238), 6.99, 18.02, 26.16, 37.14, 14.95, 38.61, 17.21, 42.85);
    var store1 = new Store("Ray\'s Liquor", LatLng(39.724227, -121.849057), 10.51, 18.78, 27.33, 30.79, 13.61, 51.66, 16.56, 26.28);
    var store2 = new Store("Liquor Bank", LatLng(39.725835, -121.834367), 5.33, 20.34, 11.76, 45.16, 17.11, 24.79, 17.62, 23.71);
    var store3 = new Store("Tony\'s Liquor", LatLng(39.733361, -121.854040), 7.67, 24.53, 23.61, 37.31, 14.33, 34.54, 16.46, 20.73);
    var store4 = new Store("Star Liquors", LatLng(39.730483, -121.858090), 8.63, 17.99, 24.33, 34.98, 18.38, 22.66, 17.56, 37.37);
    var store5 = new Store("Duke\'s Cork-N\'-Bottle Shop", LatLng(39.723882, -121.830664), 8.53, 16.21, 18.22, 32.98, 30.71, 26.19, 17.75, 24.12);
    var store6 = new Store("Mangrove Bottle Shop", LatLng(39.744469, -121.839824), 8.14, 29.94, 23.47, 38.86, 17.14, 54.13, 18.28, 22.75);
    var store7 = new Store("Safeway Liquor", LatLng(39.736488, -121.833654), 5.14, 20.88, 22.95, 47.85, 17.54, 40.15, 17.75, 41.92);
    var store8 = new Store("Anthony\'s Liquor", LatLng(39.748353, -121.853910), 6.47, 17.06, 26.82, 31.59, 25.98, 35.72, 16.13, 30.51);
    var store9 = new Store("Safeway", LatLng(39.732109, -121.859379), 8.42, 17.58, 22.19, 42.76, 28.96, 24.33, 17.93, 24.74);
    var store10 = new Store("Spike\'s Bottle Shop", LatLng(39.749772, -121.826377), 7.22, 24.87, 10.26, 39.16, 21.91, 37.73, 20.56, 36.94);
    var store11 = new Store("Finnegan\'s Jug Liquor", LatLng(39.746243, -121.831044), 8.36, 28.76, 24.98, 41.87, 12.45, 46.74, 17.27, 46.24);
    var store12 = new Store("Fair St. Market", LatLng(39.721845, -121.820346), 10.79, 32.66, 14.24, 50.68, 22.97, 45.16, 15.78, 28.51);
    var store13 = new Store("City Liquor & Market", LatLng(39.764968, -121.869219), 9.76, 32.49, 25.54, 45.26, 11.35, 36.99, 20.18, 23.89);
    var store14 = new Store("East Avenue Liquor", LatLng(39.762085, -121.824005), 5.83, 32.79, 24.67, 32.91, 14.84, 38.35, 15.61, 21.75);
    var store15 = new Store("Wine Cellar", LatLng(39.761229, -121.842430), 6.12, 21.93, 24.92, 34.52, 14.43, 49.18, 15.67, 39.47);
    var store16 = new Store("Safeway Liquor 2", LatLng(39.762637, -121.822527), 8.43, 25.25, 28.66, 48.87, 25.28, 22.26, 15.95, 28.13);
    var store17 = new Store("Tony\'s Market & Liquor", LatLng(39.751677, -121.825517), 10.13, 25.31, 17.23, 47.77, 30.86, 50.52, 20.18, 44.98);
    var store18 = new Store("Roney Wines", LatLng(39.747726, -121.792571), 5.71, 17.63, 18.25, 38.84, 25.66, 37.93, 17.96, 34.33);
    var store19 = new Store("Downtown Liquor & Market", LatLng(39.729171, -121.831854), 8.56, 18.54, 22.37, 39.33, 28.33, 54.39, 20.93, 30.33);
    var store20 = new Store("California Park Market", LatLng(39.750952, -121.794976), 8.27, 32.84, 23.15, 42.63, 24.45, 24.87, 19.23, 26.73);


    markerList.add(store);
    markerList.add(store1);
    markerList.add(store2);
    markerList.add(store3);
    markerList.add(store4);
    markerList.add(store5);
    markerList.add(store6);
    markerList.add(store7);
    markerList.add(store8);
    markerList.add(store9);
    markerList.add(store10);
    markerList.add(store11);
    markerList.add(store12);
    markerList.add(store13);
    markerList.add(store14);
    markerList.add(store15);
    markerList.add(store16);
    markerList.add(store17);
    markerList.add(store18);
    markerList.add(store19);
    markerList.add(store20);
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
  double _maxPrice = 10;  // filter



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
                            _maxPrice = double.parse(newValue);
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
