// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String labelText = "", String hintText = "", Widget icon]) {
    return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        prefixIcon: icon);
  }
}

class FormStyle {}
