
import 'package:flutter/material.dart';
import 'package:weather_app/data/app_text.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'package:weather_app/data/theme.dart';
import 'package:weather_app/second_screen.dart';
import 'package:weather_app/widgets/primary_button.dart';

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
                SizedBox(height: 51,),
                Text(
                  AppText.text1,
                  style: AppTextstyle.textStyle64whiteW700,
                  textAlign: TextAlign.center,
                ),
                Text(
                  AppText.text2,
                  style: AppTextstyle.textStyle64YellowW700,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 53,),
                PrimaryButton(
                    height: 72,
                    width: 304,
                    radius: 50,
                    color: Color(0xFFDDB130),
                    title: "Get start",

                    textStyle: TextStyle(
                      color: Color(0xFF362A84),
                      fontSize: 28,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w700,
                      height: 1.06,
                      letterSpacing: 0.47
                    ),
                  onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>SecondScreen()),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
