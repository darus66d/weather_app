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
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  "Precipitations\nMax: 24° Min: 18°",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16
                ),
              ),
              SizedBox(height: 20,),
              Image.asset("assets/images/house.png",height:150),
              Spacer(),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius:BorderRadius.circular(25),
                ),
                child: Row(

                ),

              )



            ],
          ),
        ),
      ),
    );
  }
}
