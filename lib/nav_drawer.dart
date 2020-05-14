import 'package:flutter/material.dart';
import 'main.dart';
import 'ad_page.dart';

// renders the hamburger menu
class NavDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text("Discount Alcohol",
                style: TextStyle(fontSize: 26, color: Colors.white)
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),

          // route to Home page
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => MyHomePage(title: "DiscountAlcohol")
            ))
          ),

          // route to Deals page
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text("Deals"),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => AdPageFrame()
            ))
          ),
        ]
      )
    );
  }
}
