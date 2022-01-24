import 'package:flutter/material.dart';
import 'package:flutter_ui_series/PlainScreen.dart';
import 'CustomDrawer.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    home: const PlainScreen(),
  ));
}




