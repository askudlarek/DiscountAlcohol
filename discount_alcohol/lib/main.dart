import 'package:flutter/material.dart';
import 'mapPage.dart';
import 'nav_drawer.dart';

void main() => runApp(DiscountAlcohol());

class DiscountAlcohol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiscountAlcohol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DiscountAlcohol'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // used by getGridCells to build grid view in homepage
  Widget getGridCell(String text) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(40, 0, 0, 0),
      ),
      child: GestureDetector(
        onTap: () => loadMapPage(text),
          child: Card(
            child: Center(
              child: Text(text),
            ),
          )
      )
    );
  }

  loadMapPage(String text) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext bc) {
        return MapPageFrame(text);
      }
    ));
  }

  // builds a list of grid cells for the homepage
  List<Widget> getGridCells(List<String> texts) {
    List<Widget> widgets = [];
    for (String s in texts) {
      widgets.add(getGridCell(s));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.count(
            crossAxisCount: 2,  // number of columns
            children: getGridCells(["Beer",
              "Wine",
              "Vodka",
              "Whiskey",
              "Gin",
              "Champagne",
              "Rum",
              "Tequila"]
            ),
        ),
      )
    );
  }
}
