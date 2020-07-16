import 'package:flutter/material.dart';

class RegisterAddressPage extends StatelessWidget {
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
                child: Nameform()
            )
          ],
      )
    );
  }
}

class Nameform extends StatefulWidget {
  @override
  _NameformState createState() => _NameformState();
}

class _NameformState extends State<Nameform> {
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
                  labelText: 'Dirección'
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
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  Navigator.pushNamed(context,'register_email');
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
