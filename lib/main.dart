import 'package:flutter/material.dart';
import 'package:versionupdate/pages/updates.dart';
import 'pages/home.dart';
import 'pages/devices.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/devices': (context) => Devices(),
      '/updates': (context) => Updates(),
    },
  ));
}
