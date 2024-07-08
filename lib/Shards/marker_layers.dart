import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerLayerMap extends StatefulWidget {
  final LatLng blue;
  final LatLng red;
  final MapController mapController;
  const MarkerLayerMap({
    super.key,
    required this.mapController,
    required this.blue,
    required this.red,
  });

  @override
  State<MarkerLayerMap> createState() => _MarkerLayerMapState();
}

class _MarkerLayerMapState extends State<MarkerLayerMap> {
  // LatLng latEnd = LatLng(7.4477, 125.8041);
  //LatLng latStart = LatLng(7.4472, 125.8093);

  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];
    marker = [
      Marker(
        rotate: false,
        alignment: Alignment.topCenter,
        point: widget.blue,
        child: Icon(Icons.location_on, color: Colors.blue),
      ),
      Marker(
          point: widget.red,
          rotate: false,
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ))
    ];
    return MarkerLayer(
      markers: marker,
      alignment: Alignment.center,
      rotate: true,
    );
  }
}
