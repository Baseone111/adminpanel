import 'package:flutter/material.dart';
import 'package:webadminpernal/screen/admin_mainscreen.dart';
import 'package:webadminpernal/screen/resources.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // Application name
        title: 'FootPrintToFreedom',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          // useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        // A widget which will be started on application startup
        home: AdminMainScreen()
        //home: AdminResourcesManagementScreen(),
        );
  }
}
