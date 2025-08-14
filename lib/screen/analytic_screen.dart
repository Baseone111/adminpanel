import 'package:flutter/material.dart';
import 'package:webadminpernal/screen/widgets/barchart.dart';
import 'package:webadminpernal/screen/widgets/custom_charts.dart';
import 'package:webadminpernal/screen/widgets/piechart.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Analytics Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          SizedBox(height: 300, child: CustomLineChart()),
          SizedBox(height: 40),
          SizedBox(height: 300, child: CustomBarChart()),
          SizedBox(height: 40),
          SizedBox(height: 300, child: CustomPieChart()),
        ],
      ),
    );
  }
}
