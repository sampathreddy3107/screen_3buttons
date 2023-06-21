import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomUserScreen extends StatefulWidget {
  @override
  _RandomUserScreenState createState() => _RandomUserScreenState();
}

class _RandomUserScreenState extends State<RandomUserScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  Future<void> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userData = data['results'][0];
        isLoading = false;
      });
    } else {
      // Error handling
      print('Failed to fetch random user');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random User'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                userData?['picture']['large'],
              ),
            ),
            title: Text(
              '${userData?['name']['first']} ${userData?['name']['last']}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(userData?['email']),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(
              '${userData?['location']['street']['name']}, ${userData?['location']['city']}, ${userData?['location']['state']}, ${userData?['location']['country']}',
            ),
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Date of Birth: ${userData?['dob']['date']}'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Registered: ${userData?['registered']['date']}'),
            subtitle: Text('Number of Days: ${_calculateDaysSinceRegistered()}'),
          ),
        ],
      ),
    );
  }

  int _calculateDaysSinceRegistered() {
    final registeredDate = DateTime.parse(userData?['registered']['date']);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(registeredDate);
    return difference.inDays;
  }
}
