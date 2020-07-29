import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:park_control/config/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(20,40,80,1), Color.fromRGBO(17, 168, 171, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(context),
            //buttonSection(),
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
      width: MediaQuery.of(context).size.width*0.7,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 35.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text, passwordController.text);
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }

        },
        elevation: 0.0,
        color: Color.fromRGBO(10, 194, 133, 76),
        child: Text("INGRESAR", style: TextStyle(color: Palette.white,)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Palette.white
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor digita el usuario';
                }
                return null;
              },
              controller: emailController,
              cursorColor: Palette.primaryColor,
              style: TextStyle(color: Palette.primaryColor,),
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle, color: Palette.primaryColor,),
                hintText: "Usuario",
                border: UnderlineInputBorder(borderSide: BorderSide(color: Palette.lightPrimaryColor,)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Palette.primaryColor),
                ),
                hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1),),
              ),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor digita la contraseña';
                }
                return null;
              },
              controller: passwordController,
              cursorColor: Palette.primaryColor,
              obscureText: true,
              style: TextStyle(color: Palette.primaryColor,),
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Palette.primaryColor,),
                hintText: "Contraseña",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.lightPrimaryColor,)
                ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.primaryColor),
                  ),
                hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1),),
              ),
            ),
            buttonSection()
          ],
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 70.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Covid Control",
          style: TextStyle(
              color: Color.fromRGBO(245, 245, 245, 1),
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}