import 'package:flutter/material.dart';
import 'package:flutter_maps_taripa/page/home_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeMap(),
      debugShowCheckedModeBanner: false,
    );
  }
}
