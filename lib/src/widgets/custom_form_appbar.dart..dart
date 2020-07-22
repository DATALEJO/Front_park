import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';


Widget CustomAppBarForm(context, String title){
  return AppBar(
    backgroundColor: Palette.primaryColor,
    title: Text(title),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.home),
        iconSize: 28.0,
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
      ),
    ],
  );
}