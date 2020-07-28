import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(20,40,80,1), Color.fromRGBO(17, 168, 171, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    final APIURLBASE = 'http://3.91.89.247:8005/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post('$APIURLBASE/auth/obtain_token/', body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("APIURLBASE", APIURLBASE);
        Navigator.of(context).pushNamed('/');
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Color.fromRGBO(10, 194, 133, 76),
        child: Text("Ingresar", style: TextStyle(color: Color.fromRGBO(245, 245, 245, 1),)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Color.fromRGBO(245, 245, 245, 1),),
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle, color: Color.fromRGBO(245, 245, 245, 1),),
              hintText: "Usuario",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(245, 245, 245, 1),)),
              hintStyle: TextStyle(color: Color.fromRGBO(180, 180, 180, 1),),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor digite el usuario';
              }
              return null;
            },
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Color.fromRGBO(245, 245, 245, 1),),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Color.fromRGBO(245, 245, 245, 1),),
              hintText: "Contraseña",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(245, 245, 245, 1),)),
              hintStyle: TextStyle(color: Color.fromRGBO(180, 180, 180, 1),),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Covid Control",
          style: TextStyle(
              color: Color.fromRGBO(245, 245, 245, 1),
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}