// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:park_control/src/pages/register/regis_address_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterEmailPage extends StatefulWidget {
  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  registerVisitor(Map dataVisitor, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var response = await http.post('$APIURLBASE/api/v1.0/visitors/', body: dataVisitor, headers: {
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        Navigator.pushNamed(context,'register_done');
      }
    }
    else {
      print(response.body);
    }
  }

  _body(context){
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.green[100], Colors.blue[100]])
                ),
                child: Column(
                  children:<Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text('Paso 7/7', style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[700]))
                            ],
                          ),
                          FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child:
                              Icon(Icons.keyboard_arrow_left, color: Colors.grey[700],size:30,)
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 50, bottom: 40),
                    ),
                    Container(
                      child: Image(image: AssetImage('assets/regis_email.png'),width: 220,),
                    ),
                    Text("Correo Electrónico", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
                    Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text("Por favor registra el correo electrónico del visitante.",style: TextStyle(color: Colors.grey[700]),)
                    ),
                    Card(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
                        child: _bodyForm(context)
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bodyForm(context){
    final AddressPagArguments args = ModalRoute.of(context).settings.arguments;
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: TextFormField(controller: emailController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Debes escribir un correo Electrónico';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0, bottom:20.0),
                child: SizedBox(
                  width: 270,
                  child: RaisedButton(
                    color: Colors.green[400],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green[600])
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                        print('PARAMS7: ${args.params}');
                        print('TEXT: ${emailController.text}');
                        Map newparams = args.params;
                        newparams['email'] = emailController.text;
                        newparams['read_type'] = 'Manual';
                        //newparams['birthdate'] = '1990-07-04 00:00:00';
                        //newparams['covid_contact'] = 'TRUE';
                        //newparams['gender'] = 'TRUE';
                        newparams['is_active'] = 'TRUE';
                        print('ALLPARAMS: $newparams');
                        registerVisitor(newparams, context);
                    },
                    child: Text('Registrar Información'),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


}
