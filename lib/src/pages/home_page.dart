import 'package:flutter/cupertino.dart';
import 'package:park_control/login_page.dart';
import 'package:park_control/src/screens/home_screen.dart';
import 'package:park_control/src/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

  final List _screens = [
    HomeScreen(),
    StatsScreen(),
    Scaffold(),
    Scaffold(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Visitor Control", style: TextStyle(color: Colors.white)),
//        backgroundColor: Colors.blue[900],
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              sharedPreferences.clear();
//              sharedPreferences.commit();
//              Navigator.of(context).pushAndRemoveUntil(
//                  MaterialPageRoute(
//                      builder: (BuildContext context) => LoginPage()),
//                  (Route<dynamic> route) => false);
//            },
//            child: Text("Salir", style: TextStyle(color: Colors.white)),
//          ),
//        ],
//      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [Icons.home, Icons.insert_chart, Icons.event_note, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: _currentIndex == key
                            ? Colors.blue[600]
                            : Colors.blue[600],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),

//      body: Center(
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                RaisedButton(
//                  onPressed: () {
//                    Navigator.pushNamed(context,'register_name');
//                  },
//                  textColor: Colors.white,
//                  padding: const EdgeInsets.all(0.0),
//                  child: Container(
//                    decoration: const BoxDecoration(
//                      gradient: LinearGradient(
//                        colors: <Color>[
//                          Color(0xFF42A5F5),
//                          Color(0xFF42A5F5),
//                          Color(0xFF42A5F5),
//                        ],
//                      ),
//                    ),
//                    padding: const EdgeInsets.all(11.0),
//                    child:
//                    const Text('Registrar Información', style: TextStyle(fontSize: 20)),
//                  ),
//                ),
//              ]
//          )
//      ),
//      drawer: Drawer(),
    );
  }
}
