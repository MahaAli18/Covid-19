
import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasource.dart';
import 'package:tgd_covid_tracker/pannels/worldwidepannel.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Center(
        child: Text(
          "COVID-19 TRACKER",
          textAlign: TextAlign.center,
        ),
      ),
      ),
      body: SingleChildScrollView(child: Column(
        children: <Widget>[
          Container(
            height:100,
            alignment: Alignment.center,
             padding: EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(DataSource.quote,  style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16),),
          ),
          Text(
                  'Worldwide',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
          WorldwidePanel()

        ],
      )),
    );
  }
}