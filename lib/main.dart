import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/pages/home.dart';

void main() async {

  //initialize Hive
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox("myBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
