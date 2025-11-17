import 'package:flutter/material.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'package:weather_app/second_screen.dart';
import 'package:weather_app/widgets/seven_days_forecast.dart';

import 'data/app_text.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56,),
            Center(
              child: Text(
                AppText.location,
                style: AppTextstyle.textStyle24WhiteW400,
              ),
            ),
            SizedBox(height: 52,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                AppText.seven,
                style: AppTextstyle.textStyle24WhiteW700,
              ),
            ),
            SizedBox(height: 20,),
            SevenDaysForecast(),
            SizedBox(height: 25,),
            Center(
              child: Container(
                width: 352,
                height: 174,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff3e2d8f), Color(0xff9d52ac)],
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left:23,top:20),
                            child: Container(
                              child: Image.asset("assets/images/crosshairs.png"),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Padding(
                            padding: EdgeInsets.only(top: 18),
                          child: Text(
                          "AIR QUAliFY",
                            style: AppTextstyle.textStyle16WhiteW400,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                             "3-Low Health Risk",
                            style: AppTextstyle.textStyle28whiteW600,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            width: 308,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff8158C3),
                                  Color(0xfff362A84)],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          spacing: 190,
                          children: [Padding(
                              padding: EdgeInsets.only(left:20),
                            child: Text(
                               "See More",
                              style: AppTextstyle.textStyle18whiteW600,
                            ),
                          ),
                            Icon(Icons.arrow_forward_ios,
                            color: Colors.white,
                            )
                          ],

                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 43,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                      MaterialPageRoute(builder: (context)=>SecondScreen())
                    );
                  },

                )
              ],
            )
            

          ],
        ),
      ),

    );
  }
}
