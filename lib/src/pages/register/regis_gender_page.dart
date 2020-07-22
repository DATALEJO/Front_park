// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/pages/register/regis_bday_page.dart';
import 'package:park_control/src/pages/register/regis_covidconc_page.dart';
import 'package:park_control/src/pages/register/regis_id_page.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';

/// This is the stateless widget that the main application instantiates.

class RegisterGenderPage extends StatefulWidget {
  @override
  _RegisterGenderPageState createState() => _RegisterGenderPageState();
}

class GenderPagArguments {
  final Map params;
  GenderPagArguments(this.params);
}

class _RegisterGenderPageState extends State<RegisterGenderPage> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  int selectedRadio = 0;

  @override
  void initState() {
    selectedRadio = 0;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForm(context, 'Paso 5/7'),
      body:_body(context),
    );
  }

  setSelectRadio(int val){
    setState(() {
      selectedRadio = val;
    });
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
                      child: Image(image: AssetImage('assets/regis_gender.png'),width: 220,),
                      margin: EdgeInsets.only(top: 40.0),
                    ),
                    Text("Género", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Palette.white),),
                    Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text("Por favor elige el género del visitante.",style: TextStyle(color: Palette.white),)
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
    final BDayPagArguments args = ModalRoute.of(context).settings.arguments;
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonBar(
                      children: <Widget>[
                        Container(child:
                        Row(
                          children: <Widget>[
                            Text('Masculino'),
                            Radio(
                              value: 0,
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val){
                                print("El valor es: $val");
                                setSelectRadio(val);
                              },
                            ),
                          ],
                        )),
                        Spacer(flex: 5),
                        Container(child:
                        Row(
                          children: <Widget>[
                            Text('Femenino'),
                            Radio(
                              value: 1,
                              groupValue: selectedRadio,
                              activeColor: Colors.blue,
                              onChanged: (val){
                                print("El valor es: $val");
                                setSelectRadio(val);
                              },
                            ),
                          ],
                        )),
                      ],
                    )
                  ],
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
                        Map newparams = args.params;
                        var valGender = selectedRadio == 0 ? 'false' : 'true';
                        newparams['gender'] = valGender;
                        print('PARAMSGENDER: ${newparams}');
                        Navigator.pushNamed(context,'register_address', arguments: GenderPagArguments(newparams),);
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
