import 'package:flutter/material.dart';
import 'package:park_control/src/routes/routes.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Park Control",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.white70
      ),
      routes: getApplicationsRoutes(),
      initialRoute: '/',
    );
  }
}
