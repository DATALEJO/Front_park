import 'package:flutter/material.dart';
import 'package:park_control/src/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:park_control/src/screens/bottom_nav_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Park Control",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.white70,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: getApplicationsRoutes(),
      initialRoute: '/',
      //home: BottomNavScreen(),
    );
  }
}
