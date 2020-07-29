// Flutter code sample for SingleChildScrollView
// In this example, the column becomes either as big as viewport, or as big as
// the contents, whichever is biggest.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/src/widgets/custom_form_appbar.dart..dart';
import 'dart:io';
import "package:path_provider/path_provider.dart";
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class RegisTempPage extends StatefulWidget {
  final Storage storage;

  const RegisTempPage({Key key, @required this.storage}) : super(key: key);

  @override
  _NameformState createState() => _NameformState();
}

class TempPagArguments {
  final Map params;

  TempPagArguments(this.params);
}

class _NameformState extends State<RegisTempPage> {
  String state;
  List pathList = [];
  TextEditingController contoller = TextEditingController();
  final nameController = TextEditingController();
  String stateVisitor;
  String imgToshow;
  Container contButtons;
  double marginVisitor;
  Color colorTemp;
  String visitorAllowed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showFilesinDir();
  }

  Future<bool> checkAccomplishedFile(String file) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var fileS = sharedPreferences.getString('idtemp');
    var accomplished = sharedPreferences.getString('accomplished');
    if (fileS == file && accomplished == 'True') {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> _showFilesinDir() async {
    List<dynamic> dataToSend;
    var dir = await getExternalStorageDirectory();
    var dirStr = dir.path;
    Directory dirTemps;
    dir
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      if (entity.path.indexOf('temperatures') > 0) {
        dirTemps = entity;
      }
    }).onDone(() {
      dirTemps
          .list(recursive: false, followLinks: false)
          .listen((FileSystemEntity entity) {
        var pathToAdd = entity.path.replaceAll(dirStr + '/temperatures/', '');
        pathToAdd = pathToAdd.replaceAll('.txt', '');
        pathList.add(pathToAdd);
      }).onDone(() async {

        print(pathList);
        //Modifica la vista para mostrar los datos de temperatura
        String fileStr = getLastFile();
        checkAccomplishedFile(fileStr).then((check) {
          if (check) {
            print('EXECUTED: El archivo ya fue ejectuado');
          } else {
            checkTemperature(fileStr);
          }
        });
      });
    });
    return dataToSend;
  }

  Future<void> checkTemperature(fileStr) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    widget.storage.readData(fileStr).then((str) {
      sharedPreferences.setString("vtemp", str);
      setState(() {
        print(str.runtimeType);
        state = '${str.trim()}°';
        stateVisitor =
        double.parse(str) >= 38.0 ? 'NO ADMITIDO' : 'ADMITIDO';
        visitorAllowed = double.parse(str) >= 38.0 ? 'False' : 'True';
        marginVisitor = double.parse(str) >= 38.0 ? 330.0 : 0.0;
        colorTemp = double.parse(str) >= 38.0 ? Colors.red : Colors.green;
        imgToshow = double.parse(str) >= 38.0
            ? "assets/denied_visitor.png"
            : "assets/regis_done.png";
        contButtons = double.parse(str) >= 38.0
            ? Container()
            : Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.only(bottom: 300.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register_name',
                        arguments: TempPagArguments(
                            createInitialParams({
                              'allowed': visitorAllowed,
                              'value': double.parse(str.trim())
                            })));
                  },
                  padding: EdgeInsets.all(15.0),
                  color: Color.fromRGBO(10, 131, 194, 0.7),
                  child: Text(
                    'Registrar Visitante',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
    print('ARCHIVO: $fileStr');
    sharedPreferences.setString("idtemp", fileStr);
    sharedPreferences.setString("accomplished", 'False');
  }

  String getLastFile() {
    print("GETLASTFILE");
    int mayor = int.parse(pathList[0]);
    pathList.forEach((element) {
      int currentElement = int.parse(element);
      print(currentElement > mayor);
      if (currentElement > mayor) {
        mayor = currentElement;
      }
    });
    return '$mayor';
  }

//  Future<File> writeData() async{
//    setState(() {
//      state = contoller.text;
//      contoller.text = '';
//    });
//    return widget.storage.writeData(state);
//  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForm(context, ''),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Palette.primaryColor, Palette.primaryColor])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                Container(
//                  child: Image(
//                    image: AssetImage('${imgToshow ?? "assets/loading.gif"}'),
//                    width: 220,
//                  ),
//                  margin: EdgeInsets.only(top: 40.0),
//                ),
                Container(
                    margin: EdgeInsets.only(bottom: 25.0, top: 60.0),
                    child: Text('Temperatura',
                        style: TextStyle(
                            fontSize: 35.0,
                            color: Color.fromRGBO(240, 240, 240, 1),
                            fontWeight: FontWeight.bold))),
                Container(
                  width: MediaQuery.of(context).size.width * 0.51,
                  padding: EdgeInsets.only(top: 10.00, bottom: 10.00),
                  decoration: BoxDecoration(
                      color: colorTemp == null ? Colors.green : colorTemp,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 6)),
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Text('${state ?? "..."}',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.black,
                                  fontFamily: 'DisplayR'),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: marginVisitor == null ? 0 : marginVisitor),
                      child: Text(
                        '${stateVisitor ?? "..."}',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      )),
                ),
                Center(
                  child: contButtons ?? Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map createInitialParams(Map data) {
    var newParams = {};
    newParams['visit'] = {'allowed': data['allowed']};
    newParams['visitor'] = {};
    newParams['temperature_measure'] = {'value': data['value']};
    return newParams;
  }
}

class Storage {
  String strFile;

  Future<String> get localPath async {
    final dir = await getExternalStorageDirectory();
    return dir.path;
  }

  Future<File> getlocalFile(sFile) async {
    final path = await localPath;
    return File('$path/temperatures/${sFile}.txt');
  }

  Future<String> readData(String sFile) async {
    try {
      final file = await getlocalFile(sFile);
      String body = await file.readAsStringSync();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data, String sFile) async {
    strFile = sFile;
    final file = await getlocalFile(sFile);
    return file.writeAsString("$data");
  }
}
