import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomImage extends StatefulWidget {
  @override
  _RandomImageState createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {
  String imageUrl = '';

  Future<void> fetchRandomDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    } else {
      // Error handling
      print('Failed to fetch random dog image');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: fetchRandomDogImage,
            child: Text('Refresh'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Center(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )
                  : CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
