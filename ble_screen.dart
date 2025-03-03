// ble_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_ble/universal_ble.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import './device.dart';

class BleScreen extends StatefulWidget{
  dynamic args = Get.arguments;
  late Device device = devices[args];
  @override State createState() => BleScreenState();}
  
class BleScreenState extends State<BleScreen>{
  QueueType queueType = QueueType.global;
  late BleDevice device;
  late BleService service;
  late List<BleService> discoveredServices = [];
  late BleCharacteristic charTx;
  ScanFilter? scanFilter;
  var status = 'scan and connect'.obs;

void write_test(val) async {
Uint8List data=utf8.encode(val);

try{await UniversalBle.writeValue(
  device.deviceId,service.uuid,charTx.uuid,data,BleOutputProperty.withResponse);
} catch(e) {print(e);}}
  
void handleScan(result) async{
if (result.deviceId == widget.device.mac){
device=result;

status.value = 'connecting...';
try{await UniversalBle.connect(device.deviceId);}
catch(e){print(e.runtimeType);print(e);}

//print("discovering services...");
try{var services=await(UniversalBle.discoverServices(device.deviceId));
discoveredServices=services;}
catch(e){print(e);}

//print("discoveredServices");
//print(discoveredServices);
for(var s in discoveredServices){
  if(s.uuid.toString() == widget.device.service_uuid){
   status.value = 'discovering services...';
   //print("service found");
   service=s;
   var chars=service.characteristics;
   for(var c in chars){
     status.value = 'finding characteristic...';
     if(c.uuid.toString() == widget.device.tx_char_uuid){
       status.value="app ready";
       charTx=c;
       break;}}}}}}

void handleConnect(String deviceId,bool isConnected,String? error){
status.value = isConnected ? "Connected" : "Scanning...";} 

void handleQueue(String id, int len){
print("queue: $id  len: $len");}

Future<void> startScan()async{
//print("startscan function");
try{await UniversalBle.stopScan();}catch(e){print(e);}
try{await UniversalBle.startScan();}catch(e){print(e);}}

@override void initState() {
super.initState();
UniversalBle.queueType = QueueType.global;//works for desktop
UniversalBle.timeout = const Duration(seconds:30);//30 works for android
//UniversalBle.timeout = const Duration(seconds:10);//works for desktop
UniversalBle.onQueueUpdate = handleQueue;
UniversalBle.onScanResult = handleScan;
UniversalBle.onConnectionChange = handleConnect;}  

  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('${widget.device?.name}')),
      body: Center(child: Column(spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        
Text('device: ${widget.device?.name}'), 

Text('''
press scan and connect and wait
for app ready before sending
anything to the device
'''),
        
ElevatedButton(onPressed:(){startScan();},
child:Obx(()=>Text('${status}'))),

ElevatedButton(onPressed:(){write_test('rgb red 500\n');},
child: Text('rgb red 500')),

ElevatedButton(onPressed:(){write_test('rgb green 500\n');},
child: Text('rgb green 500')),

ElevatedButton(onPressed:(){write_test('rgb blue 500\n');},
child: Text('rgb blue 500')),

ElevatedButton(onPressed:() => SystemNavigator.pop(), child: Text('exit'))        
        
])));}}
