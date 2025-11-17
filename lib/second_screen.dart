import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data/theme.dart';

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
              SizedBox(height: 20,),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius:BorderRadius.circular(25),
                ),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "July, 21",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherHourTile(time:'15:00',temp:'19°C'),
                      WeatherHourTile(time:'16:00',temp:'19°C'),
                      WeatherHourTile(time:'17:00',temp:'19°C'),
                      WeatherHourTile(time:'18:00',temp:'19°C'),
                    ],
                  ),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherHourTile extends StatelessWidget {
  final String time;
  final String temp;
  const WeatherHourTile({super.key, required this.time, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time,style: TextStyle(
          color: Colors.white70,),),
        Icon(Icons.cloud,color: Colors.white,),
        Text(temp,style:
          TextStyle(color: Colors.white),)
      ],
    );
  }
}


