import 'package:flutter/material.dart';
import 'package:flutter_pixabay/global.dart';
import 'package:flutter_pixabay/pages/home/home_page.dart';

void main() => Global.init().then((value) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Global.appTheme.lightTheme,
      darkTheme: Global.appTheme.darkTheme,
      home: HomePage(),
    );
  }
}
