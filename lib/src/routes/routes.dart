import 'package:flutter/material.dart';
import 'package:park_control/src/pages/register/regis_address_page.dart';
import 'package:park_control/src/pages/register/regis_bday_page.dart';
import 'package:park_control/src/pages/register/regis_covidconc_page.dart';
import 'package:park_control/src/pages/register/regis_done_page.dart';
import 'package:park_control/src/pages/register/regis_email_page.dart';
import 'package:park_control/src/pages/home_page.dart';
import 'package:park_control/src/pages/register/regis_gender_page.dart';
import 'package:park_control/src/pages/register/regis_id_page.dart';
import 'package:park_control/src/pages/register/regis_name_page.dart';
import 'package:park_control/src/pages/register/regis_temp_page.dart';
import 'package:park_control/src/screens/bottom_nav_screen.dart';


Map<String, WidgetBuilder> getApplicationsRoutes(){
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => BottomNavScreen(),
    'temp': (BuildContext context) => RegisTempPage(storage: Storage(),),
    'register_name': (BuildContext context) => RegisNameRPage(),
    'register_cedula': (BuildContext context) => RegisterIdPage(),
    'register_covconct': (BuildContext context) => RegisterCovidConctPage(),
    'register_bday': (BuildContext context) => RegisterBdayPage(),
    'register_gender': (BuildContext context) => RegisterGenderPage(),
    'register_address': (BuildContext context) => RegisterAddressPage(),
    'register_email': (BuildContext context) => RegisterEmailPage(),
    'register_done': (BuildContext context) => RegisterDonePage(),
  };
}


