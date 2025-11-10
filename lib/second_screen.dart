import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/theme.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kPrimaryGradient
        ) ,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 60,
          ),
          child: Column(
            children: [
              Image.asset("assets/images/image1.png",height: 100,),
              SizedBox(height: 10,),
              Text(
                '19°',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
