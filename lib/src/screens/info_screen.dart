import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/config/styles.dart';
import 'package:park_control/data/data.dart';
import 'package:park_control/src/widgets/widgets.dart';


class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _country = 'USA';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Container(
            child: Align(
              child:_buildHeader(screenHeight),
              alignment: Alignment.center,
            )
        ),
      )
    );
  }

  Container _buildHeader(double screenHeight) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Info',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Esta Aplicación permite realizar toma de temperatura y captura de información de ususarios con el fin de cumplir algunos los protocolos de seguridad impuestos por el gobierno nacional para el funcionamiento de locales comerciales.',
                style: const TextStyle(
                  color: Palette.white,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(top:30.0),
                child: Text(
                  'Datalejo 2020 ©',
                  style: const TextStyle(
                    color: Palette.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tips de Prevención',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                children: <Widget>[
                  Image.asset(
                    e.keys.first,
                    height: screenHeight * 0.12,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    e.values.first,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/danger_temperature.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Medición de Temperatura',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'No permitas el ingreso de \npersonas con alta \ntemperatura.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
