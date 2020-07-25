import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_control/config/palette.dart';
import 'package:park_control/config/styles.dart';
import 'package:park_control/data/data.dart';
import 'package:park_control/src/widgets/custom_app_bar.dart';
import 'package:park_control/src/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<double> covidCases;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTempMeasures();
    covidCases = [0.0,0.0,0.0,0.0,0.0];
  }

  getTempMeasures() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final APIURLBASE = sharedPreferences.getString('APIURLBASE');
    var jsonResponse = null;
    print('Entra a registrar');
    var response = await http.get(
        '$APIURLBASE/api/v1.0/temperature-measure/last_five/', headers: {
      'Accept': 'application/json',
      'Authorization': 'JWT $token'
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      List<dynamic> dataP = jsonResponse['response'];
      List<double> cleanList = [];
      dataP.forEach((element) {
        if(element.runtimeType != double){
          cleanList.add(element.toDouble());
        }else{
          cleanList.add(element);
        }
      });
      setState(() {
        print(cleanList);
        covidCases = cleanList;
      });
    }
    else {
      print("Error");
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top:20.0, left: 20.0, right: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(
                covidCases: covidCases
              ),
            ),
          )
        ],
      ),
    );
  }
  SliverPadding _buildHeader(){
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Estadísticas',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar(){
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal:20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular((25.0)
            )
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('My Country'),
              Text('Global')
            ],
            onTap: (index){

            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Total'),
              Text('Hoy'),
              Text('Ayer'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
