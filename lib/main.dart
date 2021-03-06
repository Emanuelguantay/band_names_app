import 'package:band_names_app/src/pages/home_page.dart';
import 'package:band_names_app/src/pages/status_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'status',
      routes: {
        'home':(_) => HomePage(),
        'status':(_) => StatusPage()
      },
    );
  }
}