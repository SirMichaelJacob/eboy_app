// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, prefer_const_constructors,prefer_const_literals_to_create_immutables,, avoid_print, unused_field, unused_local_variable, unused_import

import 'package:eboy_app/controllers/householdController.dart';
import 'package:eboy_app/controllers/registrationController.dart';
import 'package:eboy_app/screens/Homescreen.dart';
import 'package:eboy_app/screens/HouseErrandScreen.dart';
import 'package:eboy_app/screens/PickupView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoder_location/geocoder.dart';

import 'DBService/DBServer.dart';
import 'controllers/locationController.dart';
import 'screens/Splashscreen.dart';

Size size; //Screen Size

void main() async {
  await GetStorage.init(); //Initialize Get Storage

  LocationController locationController = Get.put(LocationController());
  HouseholdController householdController = Get.put(HouseholdController());
  RegistrationController registrationController =
      Get.put(RegistrationController());

  registrationController.services.clear();
  //Clear Service List and Fetch from Server

  registrationController.services.addAllIf(
      registrationController.services.isEmpty, await Server.getServices());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      home: Splashscreen(),
      theme: ThemeData(
          fontFamily: 'Font1',
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapApp(),
//     );
//   }
// }

// class MapApp extends StatefulWidget {
//   @override
//   _MapAppState createState() => _MapAppState();
// }

// class _MapAppState extends State<MapApp> {
//   LatLng _center = LatLng(9.8965, 8.8583);
//   var _point = LatLng(9.8965, 8.8583);
//   List<Placemark> _location;

//   @override
//   void initState() {
//     super.initState();
//   }

//   //
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       FlutterMap(
//         options: MapOptions(
//           center: _center,
//           zoom: 14.0,
//           onTap: (p, pt) async {
//             print("Here");

//             var _location = await Geocoder.local.findAddressesFromCoordinates(
//                 Coordinates(pt.latitude, pt.longitude));

//             print("Location: ${_location.first.locality}");

//             setState(() {
//               _point = pt;
//             });
//           },
//         ),
//         layers: [
//           TileLayerOptions(
//               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//               subdomains: ['a', 'b', 'c']),
//           MarkerLayerOptions(markers: [
//             Marker(
//               width: 100.0,
//               height: 100.0,
//               point: _point,
//               builder: (context) => Icon(Icons.location_on, color: Colors.red),
//             )
//           ])
//         ],
//       ),
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
//         child: Column(
//           children: [
//             Card(
//               child: TextField(
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.location_on_outlined),
//                     hintText: 'Search for a Location',
//                     contentPadding: EdgeInsets.all(16.0)),
//               ),
//             ),
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             )
//           ],
//         ),
//       )
//     ]);
//   }
// }
