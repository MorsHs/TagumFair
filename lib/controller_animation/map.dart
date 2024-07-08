import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_maps_taripa/Shards/center_dot.dart';
import 'package:flutter_maps_taripa/Shards/marker_layers.dart';
import 'package:flutter_maps_taripa/Shards/polyline.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // final osrm = Osrm(); //OSRM
  double distance = 0;
  int payment = 17;
  final double tagumLat = 7.448212;
  final double tagumLong = 125.809425;
  LatLng blue = LatLng(0, 0);
  LatLng red = LatLng(0, 0);
  List<LatLng> locs = [];
  final mapController = MapController();

  setPayment() {
    double holder = distance;
    if (holder == 0) {
    } else {
      while (holder > 1) {
        holder % 3;
        payment += 2;
      }
    }
  }

  void setBlue() {
    blue =
        LatLng(mapController.center.latitude, mapController.center.longitude);
  }

  getBlue() {
    return this.blue;
  }

  getBlueLat() {
    return blue.latitude;
  }

  getBlueLong() {
    return blue.longitude;
  }

  void setRed() {
    red = LatLng(mapController.center.latitude, mapController.center.longitude);
  }

  getRed() {
    return this.red;
  }

  getRedLat() {
    return this.red.latitude;
  }

  getRedLong() {
    return red.longitude;
  }

  clearPolyLine() {
    locs.clear();
  }

  /// getPolyLine need OSRM
  Future setPolyLine(
      double getBLong, double getBLat, double getRLong, double getRLat) async {
    var response = await http.get(Uri.http('router.project-osrm.org',
        '/route/v1/driving/$getBLong,$getBLat;$getRLong,$getRLat?overview=full&geometries=geojson'));
    //overview=simplified&steps=true&annotations=true&geometries=geojson FIX LATER
    var jsonData =
        jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];

    ///PROBABLY ANSWERED DO NOT TOUCH!
    // List<LatLng> coordinates = [];
    List<dynamic>? routes = jsonData != null ? List.from(jsonData) : null;
    for (int i = 0; i < routes!.length; i++) {
      locs.add(LatLng(routes[i][1], routes[i][0]));
    }
  }

  getPolyLine() {
    return locs;
  }

  void clearDistance() {
    distance = 0;
  }

  Future setDistance(
      double getBLong, double getBLat, double getRLong, double getRLat) async {
    var response = await http.get(Uri.http('router.project-osrm.org',
        '/route/v1/driving/$getBLong,$getBLat;$getRLong,$getRLat?overview=full&geometries=geojson'));
    //overview=simplified&steps=true&annotations=true&geometries=geojson FIX LATER
    /*Map<String, dynamic> jsonData =
        jsonDecode(response.body)['routes'][0]['legs'][0];*/
    double jsonData =
        jsonDecode(response.body)['routes'][0]['legs'][0]['distance'];
    distance = jsonData / 1000;
  }

  double getDistance() {
    return distance;
  }

  int getPayment() {
    return payment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("TAGUM FARE"), backgroundColor: Colors.lightGreen),
      body: SafeArea(
        child: Expanded(
          child: FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(tagumLat, tagumLong),
                applyPointerTranslucencyToLayers: true,
                maxZoom: 20,
                minZoom: 10,
                keepAlive: true,
                interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag)),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              CenterDotClass(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 300),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              clearPolyLine();
                              setBlue();
                            });
                          },
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(height: 15),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              clearPolyLine();
                              setRed();
                              setDistance(getBlueLong(), getBlueLat(),
                                  getRedLong(), getRedLat());
                            });
                          },
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.location_on),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              setPolyLine(getBlueLong(), getBlueLat(),
                                  getRedLong(), getRedLat());
                            });
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Fare Alert"),
                                      content: Text(
                                          "You will pay ${getPayment()} Pesos and Total Distance is ${getDistance()} km"),
                                    ));
                          },
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.directions_car_filled),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              MarkerLayerMap(
                mapController: mapController,
                blue: getBlue(),
                red: getRed(),
              ),
              PolyLineGuide(lats: getPolyLine()),
            ],
          ),
        ),
      ),
    );
  }
}
