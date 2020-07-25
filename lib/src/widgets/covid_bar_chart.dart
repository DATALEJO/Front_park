import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:park_control/config/styles.dart';

class CovidBarChart extends StatelessWidget {
  final List<double> covidCases;
  final cont=0;
  const CovidBarChart({
    @required this.covidCases
   });
  @override
  Widget build(BuildContext context) {
    return Container(
      height:350.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0)
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text('Últimas Mediciones',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold
              ),),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50.0,
                barTouchData: BarTouchData(
                  enabled: false
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    margin: 10.0,
                    showTitles: true,
                    textStyle: Styles.chartLabelsTextStyle,
                    rotateAngle: 35.0,
                    getTitles: (double value){
                      switch(value.toInt()){
                        case 0:
                          return 'última';
                        case 1:
                          return 'penul..';
                        case 2:
                          return 'antepenu..';
                        case 3:
                          return 'siguiente';
                        case 4:
                          return 'siguiente';
                        default:
                          return '';
                      }
                    }
                  ),
                  leftTitles: SideTitles(
                    margin: 10.0,
                    showTitles: true,
                    textStyle: Styles.chartLabelsTextStyle,
                    getTitles: (value){
                      if(value == 0){
                        return '0°';
                      }else if(value % 5 == 0){
                        return '${value.toInt()}°';
                      }else if(value == 10){
                        return '$value';
                      }
                      return '';
                    }
                  )
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 3 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.black12,
                    strokeWidth: 1.0,
                    dashArray: [5]
                  )
                ),
                borderData: FlBorderData(
                  show: false
                ),
                barGroups: covidCases
                    .asMap()
                    .map((key, value) => MapEntry(
                  key,
                  BarChartGroupData(
                    x:key,
                    barRods: [BarChartRodData(y:value, color: Colors.red)]
                  )
                )).values.toList(),
              )
            ),
          )
        ],
      ),
    );
  }
}
