// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  RxBool loading = false.obs;
  Rx<LatLng> initialPosition = LatLng(9.8965, 8.8583).obs;
  Rx<Location> initialLocation = Location().obs;

  RxList<LatLng> availableEboys =
      [LatLng(9.8966, 8.9), LatLng(9.8967, 8.89), LatLng(9.8968, 8.93)].obs;

  RxString address = "".obs;
}
