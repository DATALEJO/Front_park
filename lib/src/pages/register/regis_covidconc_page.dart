import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCovidConctPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Registro de Visitante'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Card(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Emailform()
            )
          ],
      )
    );
  }


}

class Emailform extends StatefulWidget {

  @override
  _EmailformState createState() => _EmailformState();
}

class _EmailformState extends State<Emailform> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void registerVisitor(visitorData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(" GETTOKEN ");
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('API: $APIURLBASE');
    var response = await http.post('${APIURLBASE}api/v1.0/visitors/',body: visitorData, headers:{
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    });
    if(response.statusCode == 201) {
      print('Usuario Registrado !!!');
    }else{
      print(response.body);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Correo Electrónico'
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Debes escribir un nombre';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0, bottom:10.0),
            child: RaisedButton(
              onPressed: () {
                Map userTest = {
                  'name':'Victor',
                  'read_type':'Automático',
                  'cedula':'10563525',
                  'is_active':'TRUE'
                };
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Siguiente'),
            ),
          )
        ],
      ),
    );
  }


}
