import 'package:flutter/material.dart';
import 'package:flutter_maps_taripa/Shards/marker_layers.dart';
import 'package:latlong2/latlong.dart';

class SideButtonRight extends StatelessWidget {
  final LatLng lats;
  const SideButtonRight({super.key, required this.lats});

  @override
  Widget build(BuildContext context) {
    MarkerLayerMap mark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 300),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: Icon(Icons.location_on_outlined),
              ),
              SizedBox(height: 15),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: Icon(Icons.location_on),
              )
            ],
          ),
        ),
      ],
    );
  }
}
