import 'package:flutter/material.dart';
import 'nav_drawer.dart';

// builds scaffold for deals / ads page
class AdPageFrame extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DiscountAlcohol"),
        ),
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        body: Container(
          padding: EdgeInsets.all(12.0),
          // TODO: use real data
          child: ListView(
            children: <Widget>[
              AdHeader(),
              AdWidget(6, 99),
              AdWidget(12, 34),
              AdWidget(11, 99),
            ]
          )
        )
    );
  }
}

// displays header at top of list of deals
class AdHeader extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          "Today's Deals",
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        )
      )
    );
  }
}

// displays one deal on the deals page
class AdWidget extends StatelessWidget {
  AdWidget(this._priceDollars, this._priceCents);

  // beverage price, dollar portion
  final int _priceDollars;
  // beverage price, decimal portion
  final int _priceCents;
  // TODO: add vendor info, beverage type, etc

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Buy This Drink"),
        subtitle: Text("\$$_priceDollars.$_priceCents"),
        leading: Icon(Icons.local_drink)
      )
    );
  }
}
