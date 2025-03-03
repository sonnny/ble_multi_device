// home.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_ble/universal_ble.dart';
import './device.dart';
import './ble_screen.dart';

var items = [
  DropdownMenuItem(child: Text('${devices[0].name}'), value: 0),
  DropdownMenuItem(child: Text('${devices[1].name}'), value: 1),
  DropdownMenuItem(child: Text('${devices[2].name}'), value: 2),
  DropdownMenuItem(child: Text('${devices[3].name}'), value: 3),
  DropdownMenuItem(child: Text('${devices[4].name}'), value: 4)
];
  
class BleChooser extends StatelessWidget{
  int? dropdown = 0;

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title: Text("BLE device chooser")),
      
      body: Center(child: Column(spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
// column childrens
TextButton(child: Text('troubleshooting'),
onPressed:() => showDialog<String>(context: context,
builder: (BuildContext context) => AlertDialog(
  title: Text('Troubleshooting'),
  content: Text('''
  android device, goto settings, click apps
  grant location permission for this app
  start stop bluetooth on settings
  restart this app
  
  linux laptop, goto settings bluetooth managers
  right click the ble device then click remove
  restart this app
  
  ble device, goto thonny start stop the
  ble python program
  
  this program has been tested on a linux laptop
  and pixel 7a and samsung s10
  '''),
  actions: <Widget>[
    TextButton(onPressed:() => Navigator.pop(context, 'OK'),
      child: Text('OK'))]))),

Text('pick the ble device below'),
        
DropdownButton(value: dropdown, icon: Icon(Icons.keyboard_arrow_down), items: items,
onChanged: (int? newValue) { Get.to(() => BleScreen(), arguments: newValue);}),

ElevatedButton(onPressed:() => SystemNavigator.pop(), child: Text('exit'))
             
])));}}
