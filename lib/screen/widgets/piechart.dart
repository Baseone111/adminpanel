import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: 'Blue',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 30,
            title: 'Red',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.green,
            value: 20,
            title: 'Green',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.yellow,
            value: 10,
            title: 'Yellow',
            radius: 50,
          ),
        ],
        centerSpaceRadius: 30,
      ),
    );
  }
}
