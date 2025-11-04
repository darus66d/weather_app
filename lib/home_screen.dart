import 'package:flutter/material.dart';
import 'package:weather_app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kPrimaryGradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image1.png',height: 120,),
          ],
        ),
      ),
    );
  }
}
