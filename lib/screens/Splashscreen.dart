// ignore_for_file: prefer_const_constructors, missing_return

import 'package:eboy_app/controllers/registrationController.dart';
import 'package:eboy_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Homescreen.dart';

class Splashscreen extends StatelessWidget {
  RegistrationController regController = Get.find();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          //scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  child: Image.asset(
                    regController.picList.elementAt(regController.indx.value),
                    width: size.width,
                    height: size.height / 1.2,
                  ),
                  onDismissed: (DismissDirection dir) {
                    if (regController.indx.value == 4) {
                      Get.to(() => HomeScreen());
                    } else {
                      regController.indx.value++;
                    }
                  },
                );
              }),
              Obx(() => Text(
                  regController.indx.value == 4 ? "Welcome" : 'Swipe >>>',
                  style: TextStyle(color: Color.fromARGB(255, 247, 142, 23))))
            ],
          )),
    );
  }
}
