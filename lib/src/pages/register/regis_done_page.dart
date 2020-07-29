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

/// This is the stateless widget that the main application instantiates.
class RegisterDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoneAppBarForm(context, 'Completado'),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 40.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Palette.primaryColor, Palette.primaryColor])
                        ),
                        child: Column(
                          children:<Widget>[
                           Card(
                             margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                    alignment: Alignment.center,
                                    child:Text("Visitante Registrado!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[700]),) ,),
                                  Container(
                                      margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                                      child: Text("Gracias por registrar la información. ¿Qué deseas hacer ahora?.",style: TextStyle(color: Colors.grey[700]),)
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: Image(image: AssetImage('assets/regis_done.png'),width: 150,),
                                  ),
                                  form()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget DoneAppBarForm(context, String title){
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.done_all, color: Colors.white,),
      iconSize: 28.0,
    ),
    backgroundColor: Palette.primaryColor,
    title: Text(title),
  );
}

class form extends StatefulWidget {
  @override
  _formState createState() => _formState();
}

class EmailPagArguments {
  final String name;
  EmailPagArguments(this.name);
}



class _formState extends State<form> {
  @override
  Widget build(BuildContext context) {
    final AddressPagArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Nuevo visitante'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue[600])
            ),
            onPressed: (){
              Navigator.pushNamed(context,'temp');
            },
          ),
          RaisedButton(
            child: Text('Terminar'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue[600])
            ),
            onPressed: (){
              Navigator.pushNamed(context,'/');
            },
          )
        ],
      ),
    );
  }
}
