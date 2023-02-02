// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../commons/themehelper.dart';
import '../controllers/registrationController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget pickupWidget(
    RegistrationController controller, FormGroup form, Size size) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    margin: EdgeInsets.only(top: size.height * 0.3),
    height: size.height / 2,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      // borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(24), topRight: Radius.circular(24)),
    ),
    child: ReactiveForm(
      formGroup: form,
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveTextField(
                formControlName: 'item',
                textInputAction: TextInputAction.next,
                validationMessages: (control) =>
                    {ValidationMessage.required: "Package Cannot be empty"},
                decoration: ThemeHelper().textInputDecoration(
                  "Package",
                  "What are we delivering?",
                  Icon(
                    FontAwesomeIcons.boxes,
                    color: Colors.deepOrangeAccent,
                  ),
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveTextField(
              formControlName: 'pickupLocation',
              textInputAction: TextInputAction.next,
              validationMessages: (control) =>
                  {ValidationMessage.required: "Package Cannot be empty"},
              decoration: ThemeHelper().textInputDecoration(
                  "Pickup Address",
                  "Where do we pickup?",
                  Icon(
                    Icons.location_city_outlined,
                    color: Colors.deepOrangeAccent,
                  )),
              //Icon(FontAwesomeIcons.searchLocation)
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveTextField(
              formControlName: 'destination',
              textInputAction: TextInputAction.next,
              validationMessages: (control) => {
                ValidationMessage.required: "Delivery Address cannot be empty"
              },
              decoration: ThemeHelper().textInputDecoration(
                  "Delivery Address",
                  "Where are we delivering to?",
                  Icon(
                    FontAwesomeIcons.city,
                    color: Colors.deepOrangeAccent,
                  )),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveDropdownField(
              formControlName: 'pickupLG',
              items: controller.lgas
                  .map((lga) =>
                      DropdownMenuItem<String>(value: lga, child: Text(lga)))
                  .toList(),
              validationMessages: (context) => {
                ValidationMessage.required:
                    "Please Select destination Local Govt."
              },
              decoration: ThemeHelper().textInputDecoration(
                "Destination Local Govt.",
                "Destination LG",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveTextField(
              formControlName: 'recipientPhone',
              textInputAction: TextInputAction.next,
              validationMessages: (control) => {
                ValidationMessage.required:
                    "Recipient Phone number cannot be empty",
                ValidationMessage.number: "Enter a valid phone number"
              },
              decoration: ThemeHelper().textInputDecoration(
                  "Recipient Phone",
                  "Phone Number of Receiver",
                  Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.deepOrangeAccent,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: ReactiveFormConsumer(
                builder: (context, form, child) => ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange)),
                    onPressed: form.valid ? () {} : null,
                    child: Text('Continue'))),
          ),
          SizedBox(height: 80)
        ],
      ),
    ),
  );
}
