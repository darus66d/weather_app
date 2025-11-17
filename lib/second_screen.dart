import 'package:flutter/material.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'package:weather_app/widgets/app_decoration.dart';
import 'data/app_text.dart';

class SecondScreen extends StatelessWidget {
   SecondScreen({super.key});
  
  final List<Map<String,String>> forecast = [
    {"temp": "19°C","icon": "assets/images/sun_rain.png","time": "15:00"},
    {"temp": "18°C","icon": "Moon cloud mid rain,png","time": "15:00"},
    {"temp": "18°C","icon": "","time": "15:00"},
    {"temp": "18°C","icon": "","time": "15:00"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 244,
              height: 244,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/image1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4,),
            Text(
              AppText.deg,
              style: AppTextstyle.textStyle64WhiteW500,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 52,),
            Text(
              AppText.precipitation,
              style: AppTextstyle.textStyle24WhiteW400,
              textAlign: TextAlign.center,
            ),
            Container(
              width: 336,
              height: 198,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home.png"),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Container(
              width: 428,
              height: 246,
              decoration: AppDecoration.gradientBox,
              padding: EdgeInsets.all(16),
              child:Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Today",style: AppTextstyle.textStyle20WhiteW600,),
                      Text("July, 21",style: AppTextstyle.textStyle20WhiteW600,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  //Divider Line
                  Container(
                    width: 428,
                    height: 0,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Color(0xFF8D78C7),
                            strokeAlign:BorderSide.strokeAlignOutside,
                          )
                        )),
                  ),
                  SizedBox(height: 20,),
                  //ForeCast Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: forecast.map((item){
                      return Column(
                        children: [
                        Text(item["temp"]!,style: AppTextstyle.textStyle20WhiteW600,),
                        SizedBox(height: 8,),
                          Image.asset(item["icon"]!,height: 40,),
                          SizedBox(height: 8,),
                          Text(item["time"]!,style: AppTextstyle.textStyle20WhiteW600,)
                        ]
                      );
                    }).toList(),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
