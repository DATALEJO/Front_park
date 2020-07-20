// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/src/pages/register/regis_name_page.dart';


class RegisterIdPage extends StatefulWidget {
  @override
  _RegisterIdPageState createState() => _RegisterIdPageState();
}

class IdPagArguments {
  final Map params;
  IdPagArguments(this.params);
}

class _RegisterIdPageState extends State<RegisterIdPage> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_body(context),
    );
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
                              Text('Paso 2/7',  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[700]))
                            ],
                          ),
                          FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.keyboard_arrow_left, color: Colors.grey[700],size:30,)

                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 50, bottom: 40),
                    ),
                    Container(
                      child: Image(image: AssetImage('assets/regis_cedula.png'),width: 220,),
                    ),
                    Text("Identificación", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
                    Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text("Por favor digita la cédula del visitante.",style: TextStyle(color: Colors.grey[700]),)
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
    final NamePagArguments args = ModalRoute.of(context).settings.arguments;
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: TextFormField(controller: idController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Debes escribir una cédula';
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
                        print('PARAMS1: ${idController.text}');
                        Navigator.pushNamed(context,'register_covconct', arguments: IdPagArguments({'name':args.name,'cedula':idController.text}),);
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


