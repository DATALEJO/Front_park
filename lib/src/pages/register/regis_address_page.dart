// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/pages/register/regis_gender_page.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';

class RegisterAddressPage extends StatefulWidget {
  @override
  _RegisterAddressPageState createState() => _RegisterAddressPageState();
}

class AddressPagArguments {
  final Map params;
  AddressPagArguments(this.params);
}

class _RegisterAddressPageState extends State<RegisterAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForm(context, 'Paso 6/7'),
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
                        colors: [Palette.primaryColor, Palette.primaryColor])
                ),
                child: Column(
                  children:<Widget>[
                    Container(
                      child: Image(image: AssetImage('assets/regis_address.png'),width: 220,),
                      margin: EdgeInsets.only(top: 40.0),
                    ),
                    Text("Dirección", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Palette.white),),
                    Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text("Por favor registra la dirección del visitante.",style: TextStyle(color: Palette.white),)
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
    final GenderPagArguments args = ModalRoute.of(context).settings.arguments;
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: TextFormField(controller: addressController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Debes escribir una dirección';
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
                        print('TEXTADDRESS: ${addressController.text}');
                        Map newparams = args.params;
                        newparams['visitor']['address'] = addressController.text;
                        print('PARAMSADDRESS: ${newparams}');
                        Navigator.pushNamed(context,'register_email', arguments: AddressPagArguments(newparams),);
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
