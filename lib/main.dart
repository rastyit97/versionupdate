import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/devices.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff4BC9F0),
        focusColor: Color(0xFF2264A9),
        backgroundColor: Colors.white,
        fontFamily: 'Lato',
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/devices',
          page: () => Devices(),
          transition: Transition.fadeIn,
        ),
      ],
    ),
  );
}
