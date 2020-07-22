// Flutter code sample for SingleChildScrollView

// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/pages/register/regis_covidconc_page.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';

class RegisterBdayPage extends StatefulWidget {
  @override
  _NameformState createState() => _NameformState();
}

class BDayPagArguments {
  final Map params;

  BDayPagArguments(this.params);
}

class _NameformState extends State<RegisterBdayPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  DateTime selectedDate = DateTime(2000, 1);
  String dateHint = 'Presiona para elegir una fecha';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForm(context, 'Paso 4/7'),
      body: _body(),
    );
  }

  _body() {
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
                        colors: [Palette.primaryColor, Palette.primaryColor])),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('assets/regis_bday.png'),
                        width: 220,
                      ),
                      margin: EdgeInsets.only(top: 40.0),
                    ),
                    Text(
                      "Fecha de Nacimiento",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Palette.white),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 15, bottom: 15),
                        child: Text(
                          "Por favor registra la fecha de nacimiento del visitante.",
                          style: TextStyle(color: Palette.white),
                        )),
                    Card(
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateHint = picked.toString().substring(0, 10);
      });
  }

  _bodyForm() {
    final covContPagArguments args = ModalRoute.of(context).settings.arguments;
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.only(left: 23.0, right: 23.0, top: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    _selectDate(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    height: 60,
                    child: Text(
                      dateHint,
                      style: TextStyle(fontSize: 13),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[600]),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                child: SizedBox(
                  width: 270,
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue[600])),
                    onPressed: () {
                      // If the form is valid, display a snackbar. In the real world
                      // you'd often call a server or save the information in a database.
                      Map newparams = args.params;
                      newparams['birthdate'] = selectedDate.toString().substring(0,19);
                      print('PARAMSBDAY: $newparams');
                      Navigator.pushNamed(context, 'register_gender', arguments: BDayPagArguments(newparams));
//                        Scaffold
//                            .of(context)
//                            .showSnackBar(SnackBar(content: Text('Procesando Información')));
//
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
