// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'dart:io';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';
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
      appBar: CustomAppBarForm(context, 'Paso 7/7'),
      body: _body(context),
    );
  }

  registerVisitor(Map dataVisitor, BuildContext context) async {
    print('MAP $dataVisitor');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var dataSend = Map<String, dynamic>.from(dataVisitor);
    print('TYPE: ${dataSend.runtimeType}');
    var response = await http.post('$APIURLBASE/api/v1.0/visitor/create/', body: jsonEncode(dataVisitor), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if(response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setFileProccesed();
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
                        colors: [Palette.primaryColor, Palette.primaryColor])
                ),
                child: Column(
                  children:<Widget>[
                    Container(
                      child: Image(image: AssetImage('assets/regis_email.png'),width: 220,),
                      margin: EdgeInsets.only(top: 40.0),
                    ),
                    Text("Correo Electrónico", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Palette.white),),
                    Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text("Por favor registra el correo electrónico del visitante.",style: TextStyle(color: Palette.white),)
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
                        newparams['visitor']['email'] = emailController.text;
                        newparams['visitor']['read_type'] = 'Manual';
                        newparams['visitor']['is_active'] = 'True';
                        //print('ALLPARAMS: $newparams');
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

  setFileProccesed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('accomplished', 'True');
    print(sharedPreferences.getString('accomplished'));
  }


}
