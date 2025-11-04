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
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 428,
                height: 428,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/image1.png"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              // Image.asset('assets/images/image1.png',height: 120),
              SizedBox(height: 50,),
              Text("Weather",
              style: GoogleFonts.poppins(
                fontSize: 64,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text("ForeCasts",
                style: GoogleFonts.poppins(
                  fontSize: 64,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 55,),
              ElevatedButton(
                  onPressed: (){

                  },
                  child: Text("Get Start",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
