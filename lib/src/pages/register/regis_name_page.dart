// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';

class RegisNameRPage extends StatefulWidget {
  @override
  _NameformState createState() => _NameformState();
}

class NamePagArguments {
  final String name;
  NamePagArguments(this.name);
}

class _NameformState extends State<RegisNameRPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForm(context, 'Paso 1/7'),
      body:_body(),
    );
  }

  _body(){
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
                        child: Image(image: AssetImage('assets/profile_guess.png'),width: 220,),
                        margin: EdgeInsets.only(top: 40.0),
                      ),
                      Text("Nombre", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Palette.white),),
                      Container(
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                          child: Text("Digita el nombre y apellido del visitante.",style: TextStyle(color: Palette.white),)
                      ),
                      Card(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
                          child: _bodyForm(),
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

  _bodyForm(){
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: TextFormField(controller: nameController,
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
                margin: const EdgeInsets.only(top: 15.0, bottom:20.0),
                child: SizedBox(
                  width: 270,
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue[600])
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        Navigator.pushNamed(context,'register_cedula', arguments: NamePagArguments(nameController.text),);
                        Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(content: Text('Procesando Información')));
                      }
                    },
                    child: Text('Siguiente'),
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
