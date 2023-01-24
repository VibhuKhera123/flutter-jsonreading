import 'package:flutter/material.dart';
import 'package:internproj/routs.dart';
import 'package:internproj/screen_a.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        firstscreen: (context) => const MyHomePage(),
        //thirdscreen: (context) => const ScreenC(),
      },
    );
  }
}
