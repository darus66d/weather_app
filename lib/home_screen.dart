import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            SizedBox(height: 30,),
            Text("Weather",
            style: GoogleFonts.poppins(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text("ForeCasts",
              style: GoogleFonts.poppins(
                fontSize: 36,
                color: Colors.yellowAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
