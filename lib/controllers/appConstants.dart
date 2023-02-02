// ignore_for_file: file_names, prefer_const_constructors, avoid_print, unused_local_variable

//import 'dart:js';

import 'package:eboy_app/DBService/DBServer.dart';
import 'package:eboy_app/controllers/householdController.dart';
import 'package:eboy_app/controllers/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:geocoder_flutter/geocoder.dart' as fgeo;
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'locationController.dart';
import 'package:geocode/geocode.dart';

class AppConstants {
  static const String appName = 'Errand Boy';
  static String pageTitle = "";

//Colors
  static const Color trueBlue = Color.fromRGBO(0, 106, 224, 1);
  static const Color blueishGreenColor = Color.fromRGBO(16, 118, 145, 1);
  static const Color itemColor1 = Color.fromRGBO(160, 183, 10, 1);
  static const Color iconsColor = Color.fromARGB(255, 247, 144, 10);
  static const Color appBarColor = Color.fromRGBO(220, 10, 50, 1);
  static const Color lightTealColor = Color.fromRGBO(35, 163, 154, 1);
  static const Color darkGreenColor = Color.fromRGBO(8, 50, 33, 1);
  static const Color greenishColor = Color.fromRGBO(30, 82, 24, 1);
  static const Color darkTealColor = Color.fromRGBO(16, 118, 145, 1);
  static const Color tealishColor = Color.fromRGBO(1, 170, 161, 1);
  static const Color textColor1 = Color.fromRGBO(220, 60, 50, 1);
  static const Color itemsColor = Color.fromRGBO(220, 220, 220, 1);
  static const Color secondaryColor = Color.fromRGBO(210, 200, 210, 1);
  static const Color mainColor = Color(0xffb74093);

  static const String salt = 'edima';

  static Location location = Location();
  static bool _serviceEnabled;
  static PermissionStatus _permissionGranted;
  static LocationData _locationData;

  static loadResources(RegistrationController controller) async {
    var errands = controller.userErrands;
    errands = (await Server.getUserErrands(controller.currentUser.id)).obs;
    controller.userErrands.clear();
    controller.userErrands.addAllIf(controller.userErrands.isEmpty, errands);
    print('Running Services >> ${controller.services.length}');
    print('User Errands >> ${controller.userErrands.length}');
    // }
  }

  static loadHouseErrands(HouseholdController hController) async {
    RegistrationController controller = Get.find<RegistrationController>();
    var hErrand = hController.hErrands;
    hErrand = (await Server.getUserHErrands(controller.currentUser.id)).obs;
    hController.hErrands.clear();
    hController.hErrands.addAllIf(hController.hErrands.isEmpty, hErrand);
    print('User House Errand >> ${hController.hErrands.length}');
  }

  static findUser(LocationController locationController) async {
    GeoCode geocode = GeoCode();
    _serviceEnabled = await location.serviceEnabled();
    //printInfo(info: "here");
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    //printInfo(info: "Granted");
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      //printInfo(info: "not");
      if (_permissionGranted != PermissionStatus.granted) {
        //printInfo(info: "Not done");
        return;
      }
    }

    _locationData = await location.getLocation();

    //printInfo(info: "Latitiude=> ${_locationData.latitude}");

    var coordinates =
        fgeo.Coordinates(_locationData.latitude, _locationData.longitude);
    locationController.initialPosition.value =
        LatLng(_locationData.latitude, _locationData.longitude);

    print("Lat: ${_locationData.latitude}, Long: ${_locationData.longitude}");
    var userAddress = await geocode.reverseGeocoding(
        latitude: _locationData.latitude, longitude: _locationData.longitude);

    // List<Address> locations =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

    //await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // return locationController.address.value =
    // "${locations.first.locality}, ${locations.first.subAdminArea}, ${locations.first.adminArea}";

    //return "";
    locationController.address.value =
        "${userAddress.city}, ${userAddress.countryName}";
    return locationController.address.value;
  }
}
