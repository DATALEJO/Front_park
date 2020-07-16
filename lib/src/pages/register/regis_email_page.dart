// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/src/pages/register/regis_address_page.dart';

/// This is the stateless widget that the main application instantiates.
class RegisterEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
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
                                      child: Icon(Icons.keyboard_arrow_left, color: Colors.grey[700],size:30,)
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(top: 50, bottom: 40),
                            ),
                            Container(
                              child: Image(image: AssetImage('assets/profile_guess.png'),width: 220,),
                            ),
                            Text("Registro", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
                            Container(
                                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                                child: Text("Por favor diligencia los datos del visitante.",style: TextStyle(color: Colors.grey[700]),)
                            ),
                            Card(
                                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
                                child: Nameform()
                            )
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

class Nameform extends StatefulWidget {
  @override
  _NameformState createState() => _NameformState();
}

class EmailPagArguments {
  final String name;
  EmailPagArguments(this.name);
}

class _NameformState extends State<Nameform> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddressPagArguments args = ModalRoute.of(context).settings.arguments;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
            child: TextFormField(controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Correo Electrónico'
              ),
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
                    print('PARAMS7: ${args.params}');
                    print('TEXT: ${emailController.text}');
                    Map newparams = args.params;
                    newparams['email'] = emailController.text;
                    print('ALLPARAMS: $newparams');
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

    );
  }
}
