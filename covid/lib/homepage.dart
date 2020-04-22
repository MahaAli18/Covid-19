import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasource.dart';
import 'package:tgd_covid_tracker/panels/worldwidepanel.dart';
import 'package:tgd_covid_tracker/panels/mosteffectedcountries.dart';
import 'package:tgd_covid_tracker/panels/infoPanel.dart';
import 'package:tgd_covid_tracker/pages/countyPage.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    Map worldData;
    fetchWorldData()async{
      http.Response response = await http.get('https://corona.lmao.ninja/V2/all');
       setState(() {
        worldData = json.decode(response.body);
     });
    }

     List countryData;
      fetchCountryData() async {
        http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
        setState(() {
          countryData = json.decode(response.body);
    });
  }

    @override
    void initState() {
    fetchWorldData();
    fetchCountryData();
    super.initState();
  }







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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Worldwide', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
                GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                      },
                      child: Container(
                      decoration: BoxDecoration(
                      color: primaryBlack,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text('Regional', style: TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.bold,),)),
                ),
              ],
            ),

          ),
           worldData == null
              ? CircularProgressIndicator()
              : WorldwidePanel(
                  worldData: worldData,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Most Affected Countries', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
                ),
                SizedBox(height: 10,), 
           countryData == null
              ? Container()
              : MostAffectedPanel(
                  countryData: countryData,
                ),

             InfoPanel(),
             SizedBox(height: 20,),
             Center(child: Text("WE ARE TOGETHER IN THE FIGHT", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),)), 
             SizedBox(height: 50,)   

        ],
      )),
    );
  }
}