// ignore_for_file: unnecessary_const, must_be_immutable,  prefer_const_constructors, unused_import, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/universe.dart';

import '../controllers/locationController.dart';

class Mapview extends StatelessWidget {
  LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    // List<Marker> markers = [];
    // locationController.availableEboys.map(
    //   (person) => [person.latitude, person.longitude],
    // );
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          U.OpenStreetMap(
            center: [9.8965, 8.8583],
            zoom: 15.0,
            showLocationMarker: true,
            type: OpenStreetMapType.Mapnik,
            markers: U.MarkerLayer(locationController.availableEboys
                .map(
                  (person) => U.Marker([person.latitude, person.longitude]),
                )
                .toList()),
          )
        ],
      ),
    );
  }
}
