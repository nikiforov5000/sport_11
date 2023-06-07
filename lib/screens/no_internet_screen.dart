import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  static String id = '/no_internet_screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.wifi_off, color: Colors.white,
              size: 100.0, // you can change the size as you want
            ),
            SizedBox(height: 20.0),
            // space between the icon and text
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Unable to connect. \nPlease check your internet connection.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
