import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnableBluetooth extends StatelessWidget {
  static const platform = MethodChannel('bluetooth_channel');

  Future<void> enableBluetooth() async {
    try {
      final bool isEnabled = await platform.invokeMethod('enableBluetooth');
      if (isEnabled) {
        print('Bluetooth enabled');
      } else {
        print('Bluetooth already enabled');
      }
    } on PlatformException catch (e) {
      print('Error enabling Bluetooth: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: enableBluetooth,
          child: Text('Enable Bluetooth'),
        ),
      ),
    );
  }
}
