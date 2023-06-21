import 'package:flutter/material.dart';
import 'package:screen_3buttons/Screens/Enable_Bluetooth/Enable_Bluetooth.dart';
import 'package:screen_3buttons/Screens/RandomUserScreen.dart';
import 'package:screen_3buttons/Screens/Random_Images.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RandomImage()));
              },
              child: Text('Random Dog Images'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EnableBluetooth()));
                },
              child: Text('Enable Bluetooth'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RandomUserScreen()));
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
