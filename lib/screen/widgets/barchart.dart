import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text('Q${value.toInt() + 1}'),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 8, color: Colors.blue),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 10, color: Colors.red),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 14, color: Colors.green),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 15, color: Colors.orange),
          ]),
        ],
      ),
    );
  }
}
