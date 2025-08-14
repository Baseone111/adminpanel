import 'package:flutter/material.dart';
import 'package:webadminpernal/screen/admin_mainscreen.dart';

// Main App
class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FootPrintToFreedom Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
