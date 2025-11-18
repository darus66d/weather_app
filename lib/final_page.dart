// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:weather_app/data/app_text_style.dart';
// import 'package:weather_app/home_screen.dart';
// import 'package:weather_app/widgets/seven_days_forecast.dart';
//
// import 'data/app_text.dart';
//
// class FinalPage extends StatefulWidget {
//   final String city;
//
//   const FinalPage({super.key, required this.city});
//
//   @override
//   State<FinalPage> createState() => _FinalPageState();
// }
//
// class _FinalPageState extends State<FinalPage> {
//   bool loading = true;
//   Map<String, dynamic>? currentWeather;
//   List<dynamic>? sevenDays;
//   int? aqiValue;
//
//   final String apiKey = "YOUR_API_KEY";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchTodayWeather();
//   }
//
//   // 1️⃣ Today Weather → lat lon
//   Future<void> fetchTodayWeather() async {
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?q=${widget.city}&appid=$apiKey&units=metric";
//
//     final res = await http.get(Uri.parse(url));
//     final data = jsonDecode(res.body);
//
//     setState(() {
//       currentWeather = data;
//     });
//
//     double lat = data["coord"]["lat"];
//     double lon = data["coord"]["lon"];
//
//     await fetch7DaysForecast(lat, lon);
//     await fetchAirQuality(lat, lon);
//   }
//
//   // 2️⃣ 7 Days Forecast
//   Future<void> fetch7DaysForecast(double lat, double lon) async {
//     final url =
//         "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&units=metric&appid=$apiKey";
//
//     final res = await http.get(Uri.parse(url));
//     final data = jsonDecode(res.body);
//
//     setState(() {
//       sevenDays = data["daily"];
//       loading = false;
//     });
//   }
//
//   // 3️⃣ Air Quality API
//   Future<void> fetchAirQuality(double lat, double lon) async {
//     final url =
//         "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey";
//
//     final res = await http.get(Uri.parse(url));
//     final data = jsonDecode(res.body);
//
//     setState(() {
//       aqiValue = data["list"][0]["main"]["aqi"];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xff3d2c8e),
//                     Color(0xff533595),
//                     Color(0xff9d52ac)
//                   ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 56),
//
//               Center(
//                 child: Text(
//                   widget.city,
//                   style: AppTextstyle.textStyle24WhiteW400,
//                 ),
//               ),
//
//               SizedBox(height: 52),
//
//               // 7 Days Title
//               Padding(
//                 padding: const EdgeInsets.only(left: 50),
//                 child: Text(
//                   AppText.seven,
//                   style: AppTextstyle.textStyle24WhiteW700,
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // ⭐ 7 Days Forecast Widget (with data)
//               SevenDaysForecast(data: sevenDays!),
//
//               SizedBox(height: 25),
//
//               // ⭐ AIR QUALITY BOX
//               buildAirQuality(),
//
//               SizedBox(height: 43),
//
//               // ⭐ Sunrise & UV Index section
//               buildBottomCards(),
//
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // AIR QUALITY UI
//   Widget buildAirQuality() {
//     return Center(
//       child: Container(
//         width: 352,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(colors: [
//               Color(0xff3e2d8f),
//               Color(0xff9d52ac),
//             ])),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               Image.asset("assets/images/crosshairs.png", height: 30),
//               SizedBox(width: 12),
//               Text(
//                 "AIR QUALITY",
//                 style: AppTextstyle.textStyle16WhiteW400,
//               )
//             ]),
//             SizedBox(height: 20),
//             Text(
//               "AQI: $aqiValue",
//               style: AppTextstyle.textStyle28whiteW600,
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // SUNRISE / UV Index Cards UI
//   Widget buildBottomCards() {
//     final sunrise = DateTime.fromMillisecondsSinceEpoch(
//         currentWeather!["sys"]["sunrise"] * 1000);
//     final sunset = DateTime.fromMillisecondsSinceEpoch(
//         currentWeather!["sys"]["sunset"] * 1000);
//
//     final uvIndex = sevenDays![0]["uvi"];
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // 🌅 Sunrise Card
//         buildInfoCard(
//           title: "Sunrise",
//           value: "${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}",
//           subtitle:
//           "Sunset: ${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}",
//         ),
//
//         SizedBox(width: 12),
//
//         // UV Index Card
//         buildInfoCard(
//           title: "UV Index",
//           value: "$uvIndex",
//           subtitle: uvIndex < 3 ? "Low" : "Moderate",
//         )
//       ],
//     );
//   }
//
//   Widget buildInfoCard(
//       {required String title,
//         required String value,
//         required String subtitle}) {
//     return Container(
//       width: 161,
//       height: 150,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white),
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(colors: [
//           Color(0xff3e2d8f),
//           Color(0x009d52ac),
//         ]),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: AppTextstyle.textStyle16WhiteW400),
//             SizedBox(height: 10),
//             Text(value, style: AppTextstyle.textStyle28whiteW600),
//             SizedBox(height: 5),
//             Text(subtitle, style: AppTextstyle.textStyle18whiteW600),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/second_screen.dart';
import 'package:weather_app/widgets/seven_days_forecast.dart';

import 'data/app_text.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          width: double.infinity,

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
                          ),],),
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
                        MaterialPageRoute(builder: (context)=>HomeScreen())
                      );
                    },
                    child: Container(
                      width: 161,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xff3e2d8f), Color(0x009d52ac)],
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 5,
                              ),
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  child: Image.asset("assets/images/Star 1.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                AppText.sun,
                                style: AppTextstyle.textStyle16WhiteW400,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 13),
                          child:
                            Text(
                              "5:28 AM",
                              style: AppTextstyle.textStyle28whiteW600,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 13),
                            child: Text(
                               "Sunset: 7.25PM",
                              style: AppTextstyle.textStyle18whiteW600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 13,),
                  Container(
                    width: 161,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xff3e2d8f), Color(0x009d52ac)],
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 5,
                            ),
                              child: Container(
                                height: 36,
                                width: 36,
                                child: Image.asset("assets/images/Star 1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              AppText.uv,
                              style: AppTextstyle.textStyle16WhiteW400,
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 13),
                          child:
                          Text(
                            "4",
                            style: AppTextstyle.textStyle28whiteW600,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 13),
                          child: Text(
                            "Moderate",
                            style: AppTextstyle.textStyle28whiteW600,
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              )


            ],
          ),
        ),
      ),

    );
  }
}
