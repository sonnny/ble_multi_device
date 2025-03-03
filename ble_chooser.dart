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
      appBar: AppBar(title: Text("BLE device chooser")),
      
      body: Center(child: Column(spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
// column childrens
Text('''
troubleshooting, start stop micropython,
on linux laptop lower right hand click on ble icon
right click ble device and remove
on laptop stop start bluetooth

pick the ble device below to continue
'''),
        
DropdownButton(value: dropdown, icon: Icon(Icons.keyboard_arrow_down), items: items,
  onChanged: (int? newValue) { Get.to(() => BleScreen(), arguments: newValue);}),

ElevatedButton(onPressed:() => SystemNavigator.pop(), child: Text('exit'))
             
])));}}
