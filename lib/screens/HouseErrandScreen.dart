// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_required_param, must_be_immutable, use_key_in_widget_constructors, missing_return

import 'package:eboy_app/commons/themehelper.dart';
import 'package:eboy_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:super_form/super_form.dart';
import 'package:intl/intl.dart';

import '../controllers/householdController.dart';

class HouseScreen extends StatelessWidget {
  HouseholdController hController = Get.find();

  FormGroup form = FormGroup({
    'address': FormControl<String>(validators: [Validators.required]),
    'apartmentType': FormControl<String>(validators: [Validators.required]),
    'frequency': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl(validators: [Validators.number, Validators.required]),
    'startdate': FormControl<String>(validators: [Validators.required]),
  });
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 44, 134),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 44, 134),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      height: size.height / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            child: ReactiveTextField(
                              formControlName: 'address',
                              validationMessages: (context) {
                                return {
                                  ValidationMessage.required:
                                      "Address cannot be empty"
                                };
                              },
                              decoration: ThemeHelper().textInputDecoration(
                                  "Address", "Where is your home located?"),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            child: Obx(() {
                              return ReactiveDropdownField(
                                formControlName: 'apartmentType',
                                decoration: ThemeHelper().textInputDecoration(
                                    "Apartment Type", "Select apartment type"),
                                items: hController.apartmentOptions
                                    .map(
                                      (option) => DropdownMenuItem<String>(
                                          value: option, child: Text(option)),
                                    )
                                    .toList(),
                                onChanged: (String val) {
                                  hController.apartmentType.value = val;
                                },
                              );
                            }),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            child: Obx(() {
                              return ReactiveDropdownField(
                                formControlName: 'frequency',
                                decoration: ThemeHelper().textInputDecoration(
                                    "Cleaning Schedule", "Select schedule"),
                                items: hController.frequency
                                    .map(
                                      (option) => DropdownMenuItem<String>(
                                          value: option, child: Text(option)),
                                    )
                                    .toList(),
                                onChanged: (String val) {
                                  hController.selectedSchedule.value;
                                },
                              );
                            }),
                          ),

                          Obx(() {
                            var datePicked = DateTime.now();
                            return ListTile(
                              leading: Text('Select Start date:'),
                              trailing: TextButton.icon(
                                onPressed: () async {
                                  datePicked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2050));
                                  if (datePicked == null) {
                                    return;
                                  }
                                  var formatedDate = DateFormat.yMMMd().format(
                                      datePicked); //Format the date to "Month date, Year"
                                  hController.startDate.value = formatedDate;
                                },
                                icon: Icon(FlutterRemix.calendar_event_line),
                                label: Text(hController.startDate.value == ""
                                    ? DateFormat.yMMMd().format(datePicked)
                                    : hController.startDate.value),
                                style:
                                    ButtonStyle(alignment: Alignment.topCenter),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's clean your Home.",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Home Cleaning",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.location_on_outlined,
                                    color: Colors.white),
                                Flexible(
                                  child: Text(
                                    'Jos, Nigeria',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/cleaning.png',
                                    height: 200,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ReactiveFormConsumer(
                        builder: (context, form, child) => ElevatedButton(
                          onPressed: () {},
                          child: Text("Continue"),
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(200, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange)),
                        ),
                      ),
                    ),

//                     showDatePicker(
//                       context: context,
//                        initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.utc(2050)
//                     ).then((value) {
//   SuperForm.of(context, listen: false).setValue("to", value);
// })
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
