// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, unused_import, must_be_immutable

import 'package:eboy_app/controllers/locationController.dart';
import 'package:eboy_app/controllers/registrationController.dart';
import 'package:eboy_app/screens/PickupView.dart';
import 'package:flutter/material.dart';
import 'package:geocoder_flutter/geocoder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import '../DBService/DBServer.dart';
import '../controllers/appConstants.dart';
import '../models/eService.dart';
import 'HouseErrandScreen.dart';
import 'Mapview.dart';

class HomeScreen extends StatelessWidget {
  LocationController locationController = Get.find();
  RegistrationController registrationController = Get.find();
  TextEditingController delIdController = TextEditingController();

  LatLng position;

  loadServices() async {
    registrationController.services.value = [];
    //Clear Service List and Fetch from Server

    registrationController.services.addAllIf(
        registrationController.services.isEmpty, await Server.getServices());
  }

  //
  @override
  Widget build(BuildContext context) {
    AppConstants.location.enableBackgroundMode(enable: true);

    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //padding: EdgeInsets.only(bottom: 200),
                height: MediaQuery.of(context).orientation.name == 'portrait'
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height /
                        3, //Container should occupy 1/3 of screen size
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 2, 44, 134),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Obx(() {
                          return Text(
                            locationController.address.value.isEmpty
                                ? "Fetching your Location..."
                                : 'Current Location',
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white),
                          );
                        }),
                      ),
                      Obx(() {
                        AppConstants.findUser(locationController);
                        if (locationController.address.value.isEmpty) {
                          return
                              //CircularProgressIndicator();
                              Text(
                            'Jos, Nigeria',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          );
                        } else {
                          return Text(
                            locationController.address.value,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          );
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 12),
                        child: Text(
                          'Track your Package',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Enter Delivery ID',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            )),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 10),
                              child: SizedBox(
                                height: 30,
                                child: TextField(
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search_outlined),
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        filled: true)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => Mapview());
                                },
                                child: Icon(Icons.qr_code_scanner_outlined),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 247, 142, 23)))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20, left: 20),
                child: Text('Our Services',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 78, 77, 77),
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(5.0),
                  children: serviceWidgets(registrationController.services),
                ),
              ),
            ]),
      ),
    );
  }

  Widget dashboardItem(String title, IconData icon, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10, left: 20.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 236, 235, 235),
        ),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35,
                color: AppConstants.iconsColor,
              ),
              Flexible(
                child: Text(title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13.0,
                      color: Color.fromARGB(255, 34, 33, 33),
                    )),
              ),
            ],
          ),
          onTap: onPressed,
        ),
      ),
    );
  }

  List<Widget> serviceWidgets(List<EService> services) {
    return services.map((service) {
      if (service.name == 'Pick Errand') {
        return dashboardItem(service.name, FontAwesomeIcons.running, () {
          Get.to(() => PickupView());
        });
      } else if (service.name == 'Household Cleaning') {
        return dashboardItem(service.name, FontAwesomeIcons.broom, () {
          Get.to(() => HouseScreen());
        });
      } else {
        return dashboardItem(service.name, FontAwesomeIcons.dumpster, () {});
      }
    }).toList();
  }
}
