import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                SizedBox(height: 48,),
                Text("Weather",
                style: GoogleFonts.poppins(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text("ForeCasts",
                  style: GoogleFonts.poppins(
                    fontSize: 50,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/home");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),
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
      ),
    );
  }
}
