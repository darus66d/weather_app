import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/seven_days_forecast.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'data/app_text.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  bool loading = true;

  Map<String, dynamic>? currentWeather;
  List<dynamic>? sevenDays;
  int? aqiValue;

  String apiKey = "a8590b5f50206eb6ea2e472e69d2eb4f";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  // LOCATION + ALL API CALL (FASTEST VERSION)
  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      double lat = pos.latitude;
      double lon = pos.longitude;

      // FETCH ALL 3 APIS PARALLEL
      final responses = await Future.wait([
        http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey")),
        http.get(Uri.parse(
            "https://api.openweathermap.org/data/3.0/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={API key}")),
        http.get(Uri.parse(
            "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey")),
      ]);

      // DECODE JSON
      final todayWeather = jsonDecode(responses[0].body);
      final sevenDaysData = jsonDecode(responses[1].body);
      final aqiData = jsonDecode(responses[2].body);

      setState(() {
        currentWeather = todayWeather;
        sevenDays = sevenDaysData["daily"];
        aqiValue = aqiData["list"][0]["main"]["aqi"];
        loading = false;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Location & 7-Days forecast",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff3d2c8e),
                Color(0xff533595),
                Color(0xff9d52ac),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // ⭐ CITY NAME AUTO UPDATED
              Text(
                currentWeather?["name"] ?? "Unknown",
                style: AppTextstyle.textStyle24WhiteW400,
              ),

              const SizedBox(height: 40),

              // ⭐ 8 DAYS FORECAST TITLE
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppText.seven,
                    style: AppTextstyle.textStyle24WhiteW700,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SevenDaysForecast(data: sevenDays),

              const SizedBox(height: 25),

              buildAirQualityBox(),

              const SizedBox(height: 40),

              buildBottomCards(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ⭐ AIR QUALITY BOX
  Widget buildAirQualityBox() {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xff3e2d8f),
            Color(0xff9d52ac),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Image.asset("assets/images/crosshairs.png", height: 30),
            const SizedBox(width: 12),
            Text("AIR QUALITY", style: AppTextstyle.textStyle16WhiteW400),
          ]),
          const SizedBox(height: 20),
          Text("AQI: $aqiValue", style: AppTextstyle.textStyle28whiteW600),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ⭐ SUNRISE + UV INDEX CARDS
  // ⭐ SUNRISE + UV INDEX CARDS
  Widget buildBottomCards() {
    // Null-safe sunrise & sunset
    final sunriseTimestamp = currentWeather?["sys"]?["sunrise"];
    final sunsetTimestamp = currentWeather?["sys"]?["sunset"];

    final sunrise = sunriseTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000)
        : null;

    final sunset = sunsetTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000)
        : null;

    // Null-safe UV index
    final uvIndex = (sevenDays != null && sevenDays!.isNotEmpty)
        ? sevenDays![0]["uvi"] ?? 0
        : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Sunrise Card
        infoCard(
          title: "Sunrise",
          value: sunrise != null
              ? "${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}"
              : "--:--",
          subtitle: sunset != null
              ? "Sunset: ${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}"
              : "Sunset: --:--",
        ),

        const SizedBox(width: 15),

        // UV Index Card
        infoCard(
          title: "UV Index",
          value: "$uvIndex",
          subtitle: uvIndex < 3
              ? "Low"
              : uvIndex < 6
              ? "Moderate"
              : "High",
        ),
      ],
    );
  }


  Widget infoCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xff3e2d8f),
            Color(0x009d52ac),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextstyle.textStyle16WhiteW400),
          const SizedBox(height: 10),
          Text(value, style: AppTextstyle.textStyle28whiteW600),
          const SizedBox(height: 5),
          Text(subtitle, style: AppTextstyle.textStyle18whiteW600),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:weather_app/data/app_text_style.dart';
// import 'package:weather_app/home_screen.dart';
// import 'package:weather_app/second_screen.dart';
// import 'package:weather_app/widgets/seven_days_forecast.dart';
//
// import 'data/app_text.dart';
//
// class FinalPage extends StatelessWidget {
//   const FinalPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           // height: MediaQuery.of(context).size.height,
//           // width: MediaQuery.of(context).size.width,
//           width: double.infinity,
//
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
//             )
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 56,),
//               Center(
//                 child: Text(
//                   AppText.location,
//                   style: AppTextstyle.textStyle24WhiteW400,
//                 ),
//               ),
//               SizedBox(height: 52,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 50),
//                 child: Text(
//                   AppText.seven,
//                   style: AppTextstyle.textStyle24WhiteW700,
//                 ),
//               ),
//               SizedBox(height: 20,),
//               SevenDaysForecast(),
//               SizedBox(height: 25,),
//               Center(
//                 child: Container(
//                   width: 352,
//                   height: 174,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomLeft,
//                       colors: [Color(0xff3e2d8f), Color(0xff9d52ac)],
//                     )
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.only(left:23,top:20),
//                               child: Container(
//                                 child: Image.asset("assets/images/crosshairs.png"),
//                             ),
//                           ),
//                           SizedBox(width: 12,),
//                           Padding(
//                               padding: EdgeInsets.only(top: 18),
//                             child: Text(
//                             "AIR QUAliFY",
//                               style: AppTextstyle.textStyle16WhiteW400,
//                             ),
//                           ),],),
//                           SizedBox(height: 20,),
//                           Padding(
//                             padding: EdgeInsets.only(left: 12),
//                             child: Text(
//                                "3-Low Health Risk",
//                               style: AppTextstyle.textStyle28whiteW600,
//                             ),
//                           ),
//                           SizedBox(height: 20,),
//                           Center(
//                             child: Container(
//                               width: 308,
//                               height: 4,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [Color(0xff8158C3),
//                                     Color(0xfff362A84)],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             spacing: 190,
//                             children: [Padding(
//                                 padding: EdgeInsets.only(left:20),
//                               child: Text(
//                                  "See More",
//                                 style: AppTextstyle.textStyle18whiteW600,
//                               ),
//                             ),
//                               Icon(Icons.arrow_forward_ios,
//                               color: Colors.white,
//                               )
//                             ],
//                           )
//                         ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 43,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(
//                           context,
//                         MaterialPageRoute(builder: (context)=>HomeScreen())
//                       );
//                     },
//                     child: Container(
//                       width: 161,
//                       height: 150,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 1,color: Colors.white),
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [Color(0xff3e2d8f), Color(0x009d52ac)],
//                         )
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Padding(padding: EdgeInsets.symmetric(
//                                 vertical: 14,
//                                 horizontal: 5,
//                               ),
//                                 child: Container(
//                                   height: 36,
//                                   width: 36,
//                                   child: Image.asset("assets/images/Star 1.png",
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 AppText.sun,
//                                 style: AppTextstyle.textStyle16WhiteW400,
//                                 textAlign: TextAlign.left,
//                               )
//                             ],
//                           ),
//                           Padding(padding: EdgeInsets.only(left: 13),
//                           child:
//                             Text(
//                               "5:28 AM",
//                               style: AppTextstyle.textStyle28whiteW600,
//                             ),
//                           ),
//                           Padding(padding: EdgeInsets.only(left: 13),
//                             child: Text(
//                                "Sunset: 7.25PM",
//                               style: AppTextstyle.textStyle18whiteW600,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 13,),
//                   Container(
//                     width: 161,
//                     height: 150,
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1,color: Colors.white),
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [Color(0xff3e2d8f), Color(0x009d52ac)],
//                         )
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Padding(padding: EdgeInsets.symmetric(
//                               vertical: 14,
//                               horizontal: 5,
//                             ),
//                               child: Container(
//                                 height: 36,
//                                 width: 36,
//                                 child: Image.asset("assets/images/Star 1.png",
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               AppText.uv,
//                               style: AppTextstyle.textStyle16WhiteW400,
//                               textAlign: TextAlign.left,
//                             )
//                           ],
//                         ),
//                         Padding(padding: EdgeInsets.only(left: 13),
//                           child:
//                           Text(
//                             "4",
//                             style: AppTextstyle.textStyle28whiteW600,
//                           ),
//                         ),
//                         Padding(padding: EdgeInsets.only(left: 13),
//                           child: Text(
//                             "Moderate",
//                             style: AppTextstyle.textStyle28whiteW600,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//
//                 ],
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
// }
