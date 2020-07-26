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
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class RegisTempPage extends StatefulWidget {
  final Storage storage;
  const RegisTempPage({Key key,@required this.storage}) : super(key: key);
  @override
  _NameformState createState() => _NameformState();
}




class _NameformState extends State<RegisTempPage> {
  String state;
  List pathList = [];
  TextEditingController contoller = TextEditingController();
  final nameController = TextEditingController();
  String stateVisitor;
  String imgToshow;
  Container contButtons;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showFilesinDir();
  }

  Future<List<dynamic>> _showFilesinDir() async {
    List<dynamic> dataToSend;
    var dir = await getExternalStorageDirectory();
    var dirStr = dir.path;
    Directory dirTemps;
    dir.list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      if(entity.path.indexOf('temperatures')>0){
        dirTemps = entity;
      }
    }).onDone(() {
      dirTemps.list(recursive: false, followLinks: false)
          .listen((FileSystemEntity entity) {
        var pathToAdd =  entity.path.replaceAll(dirStr+'/temperatures/', '');
        pathToAdd =  pathToAdd.replaceAll('.txt', '');
        pathList.add(pathToAdd);
      })
      .onDone(() {
          print('DOne');
          String fileStr = getLastFile();
          widget.storage.readData(fileStr).then((str){
            setState(() {
              state = '${str}';
              stateVisitor = double.parse(str) >= 38.0 ? 'NO ADMITIDO' : 'ACEPTADO';
              imgToshow = double.parse(str) >= 38.0 ? "assets/denied_visitor.png":"assets/accepted.png";
              contButtons = double.parse(str) >= 38.0 ? Container(): Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context,'register_name');
                      },
                      child: Text('Registrar Visitante'),
                    )
                  ],
                ),
              ) ;
            });
          });

      });
    });
    return dataToSend;
  }

  String getLastFile(){
    print("GETLASTFILE");
    int mayor;
     pathList.forEach((element) {
       mayor = int.parse(element);
       int currentElement = int.parse(element);
       if(currentElement>mayor){
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
      body:_body(),
    );
  }

  _body(){
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Palette.primaryColor, Palette.primaryColor])
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('${imgToshow ?? "assets/loading.gif"}'),
                      width: 220,
                    ),
                    margin: EdgeInsets.only(top: 40.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0,bottom: 20.0),
                    child: Text('${stateVisitor ?? "..."}', style:TextStyle(fontSize: 35.0, color: Colors.white),),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text('Temperatura',style: TextStyle(fontSize: 24.0, color: Colors.white)
                      )
                  ),
                  Center(
                      child: Text('${state??"..."}', style: TextStyle(fontSize: 24.0, color: Colors.white), textAlign: TextAlign.center)
                  ),
                  Center(
                    child:contButtons??Container(),
                  )
                ],
              ),
              ),
            ),
          ],
        ),
      );
  }
}

class Storage{
  String strFile;
  Future<String> get localPath async{
    final dir = await getExternalStorageDirectory();
    return dir.path;
  }

  Future<File> getlocalFile(sFile) async{
    final path = await localPath;
    return File('$path/temperatures/${sFile}.txt');
  }

  Future<String> readData(String sFile) async{
    try{
      final file = await getlocalFile(sFile);
      String body = await file.readAsStringSync();
      return body;
    }catch(e){
      return e.toString();
    }
  }

  Future<File> writeData(String data, String sFile) async{
    strFile = sFile;
    final file = await getlocalFile(sFile);
    return file.writeAsString("$data");
  }


}
