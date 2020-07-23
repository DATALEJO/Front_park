
import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  CustomAppBar(){

  }

  logOut(context) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 28.0,
        onPressed: () {},
      ),
      actions: <Widget>[
    FlatButton(
            onPressed: () {
              logOut(context);
            },
            child: Text("Salir", style: TextStyle(color: Colors.white)),
          ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          iconSize: 28.0,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
