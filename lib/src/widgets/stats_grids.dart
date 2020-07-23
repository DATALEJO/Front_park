import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  int visitorsNumber = 0;
  int aceptedNumber = 0;
  int deniedNumber = 0;
  double promAge = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getVisitorsNumber();
    getVisitorsDeniedNumber();
    getVisitorsPermitedNumber();
    super.initState();
  }

  getVisitorsNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var response = await http.get(
        '$APIURLBASE/api/v1.0/visitor/total/', headers: {
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      Map<String, dynamic> data_api = jsonDecode(response.body);
      setState(() {
        visitorsNumber = data_api['response'];
      });
    }
    else {
      print("Error");
      print(response.body);
    }
  }

  getVisitorsDeniedNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var response = await http.get('$APIURLBASE/api/v1.0/visitor/denied/', headers: {
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      Map<String, dynamic> data_api = jsonDecode(response.body);
      setState((){
        deniedNumber = data_api['response'];
      });
    }
    else {
      print("Error");
      print(response.body);
    }
  }

  getVisitorsPermitedNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var response = await http.get('$APIURLBASE/api/v1.0/visitor/permited/', headers: {
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      Map<String, dynamic> data_api = jsonDecode(response.body);
      setState((){
        aceptedNumber = data_api['response'];
      });
    }
    else {
      print("Error");
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Visitantes', '${visitorsNumber != 0 ? visitorsNumber : 'loading..'} v', Colors.orange),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Aceptados', '${aceptedNumber != 0 ? aceptedNumber : '..'} v', Colors.green),
                _buildStatCard('Denegados', '${deniedNumber != 0 ? deniedNumber : '..'} v', Colors.red),
                _buildStatCard('Edad Prom', '${promAge}', Colors.lightBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}