import 'package:flutter/material.dart';
import 'package:flutter_maps_taripa/controller_animation/map.dart';

class CenterDotClass extends StatefulWidget {
  const CenterDotClass({super.key});

  @override
  State<CenterDotClass> createState() => _CenterDotClassState();
}

class _CenterDotClassState extends State<CenterDotClass> {
  MapView s = new MapView();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      ),
    );
  }
}
