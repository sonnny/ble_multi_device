// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './ble_chooser.dart';

void main() {WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BLE demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: BleChooser(),
      debugShowCheckedModeBanner: false);}}
