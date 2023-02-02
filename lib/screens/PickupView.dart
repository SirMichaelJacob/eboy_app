// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors,prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:eboy_app/commons/themehelper.dart';
import 'package:eboy_app/screens/pickupWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../controllers/registrationController.dart';
import '../main.dart';

class PickupView extends StatelessWidget {
  RegistrationController regController = Get.find();
  FormGroup form = FormGroup({
    'item': FormControl<String>(validators: [Validators.required]),
    'pickupLocation': FormControl<String>(validators: [Validators.required]),
    'pickupLG': FormControl<String>(validators: [Validators.required]),
    'recipientPhone':
        FormControl(validators: [Validators.number, Validators.required]),
    'destination': FormControl<String>(validators: [Validators.required])
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 44, 134),
      ),
      backgroundColor: Color.fromARGB(255, 2, 44, 134),
      body: SafeArea(
        minimum: EdgeInsets.all(12),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    pickupWidget(regController, form, size),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Send Lite Packages around town.\n',
                              style: TextStyle(color: Colors.white)),
                          Text(
                            "Errand Delivery",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                              child: Text("Quick and Safe!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white))),
                          Flexible(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: Colors.deepOrange),
                              Text("Jos, Nigeria",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.white)),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/eboy.png',
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
