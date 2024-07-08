import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PolyLineGuide extends StatefulWidget {
  final List<LatLng> lats;
  const PolyLineGuide({super.key, required this.lats});

  @override
  State<PolyLineGuide> createState() => _PolyLineGuideState();
}

class _PolyLineGuideState extends State<PolyLineGuide> {
  @override
  Widget build(BuildContext context) {
    return PolylineLayer(
      polylines: [
        Polyline(
            points: widget.lats,
            color: Colors.blue,
            isDotted: false,
            strokeWidth: 9),
      ],
    );
  }
}
