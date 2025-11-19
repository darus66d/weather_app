import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/city_info.dart';
import 'package:weather_app/data/app_text_style.dart';
import 'package:weather_app/final_page.dart';
import 'package:weather_app/widgets/app_decoration.dart';
import 'data/app_text.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Map<String, dynamic>? weatherData;
  bool loading = false;

  // // Example forecast list for bottom row
  // final List<Map<String,String>> forecast = [
  //   {"temp": "19°C","icon": "assets/images/sun_rain.png","time": "15:00"},
  //   {"temp": "18°C","icon": "assets/images/Moon_cloud_mid_rain.png","time": "16:00"},
  //   {"temp": "18°C","icon": "assets/images/sun_rain.png","time": "17:00"},
  //   {"temp": "18°C","icon": "assets/images/sun_rain.png","time": "18:00"}
  // ];

  @override
  void initState() {
    super.initState();
    fetchWeatherByLocation();
  }
  Future<void> fetchWeatherByLocation() async {
    setState(() { loading = true; });

    try {
      Position position = await getCurrentLocation();
      String apiKey = 'a8590b5f50206eb6ea2e472e69d2eb4f';
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          weatherData = {
            'city': data['name'] ?? 'Unknown City',
            'temp': data['main']['temp']?.toString() ?? '--',
            'humidity': data['main']['humidity']?.toString() ?? '--',
            'precipitation': data['rain'] != null ? data['rain']['1h']?.toString() ?? '0' : '0',
          };
          loading = false;
        });
      } else {
        setState(() { loading = false; });
      }
    } catch (e) {
      setState(() { loading = false; });
      print(e);
    }
  }

  // Future<void> fetchWeather() async {
  //   setState(() {
  //     loading = true;
  //   });
  //
  //   String apiKey = 'a8590b5f50206eb6ea2e472e69d2eb4f'; // OpenWeatherMap API key
  //   String city = 'Rajshahi';
  //   String url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       setState(() {
  //         weatherData = {
  //           'city': data['name'].toString(),
  //           'temp': data['main']['temp'].toString(),
  //           'humidity': data['main']['humidity'].toString(),
  //           'precipitation': (data['rain'] != null ? data['rain']['1h'].toString() : '0'),
  //         };
  //         loading = false;
  //       });
  //     } else {
  //       setState(() {
  //         loading = false;
  //       });
  //       print('Error fetching weather');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       loading = false;
  //     });
  //     print(e);
  //   }
  // }
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current City",),
        backgroundColor: Colors.deepPurple,
        titleTextStyle: TextStyle(color: Colors.black87),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    weatherData?['city'] ?? 'City Name', // Null check + default
                    style: AppTextstyle.textStyle12whiteW500,
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 50),
                  Text(
                    weatherData != null ? '${weatherData!['temp']}°C' : AppText.deg,
                    style: AppTextstyle.textStyle64WhiteW500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    weatherData != null ? 'Precipitation: ${weatherData!['precipitation']} mm, Humidity: ${weatherData!['humidity']}%' : AppText.precipitation,
                    style: AppTextstyle.textStyle24WhiteW400,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  // House Image with overlay values
                  Stack(
                    children: [
                      Container(
                        width: 336,
                        height: 198,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/house.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (weatherData != null) ...[
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.black54,
                            child: Text(
                              '${weatherData!['temp']}°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.black54,
                            child: Text(
                              'Humidity: ${weatherData!['humidity']}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.black54,
                            child: Text(
                              'Precip: ${weatherData!['precipitation']} mm',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   width: 428,
                  //   height: 246,
                  //   decoration: AppDecoration.gradientBox,
                  //   padding: EdgeInsets.all(16),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text("Today", style: AppTextstyle.textStyle20WhiteW600),
                  //           Text("July, 21", style: AppTextstyle.textStyle20WhiteW600),
                  //         ],
                  //       ),
                  //       SizedBox(height: 20),
                  //       Container(
                  //         width: 428,
                  //         height: 0,
                  //         decoration: ShapeDecoration(
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(
                  //               width: 2,
                  //               color: Color(0xFF8D78C7),
                  //               strokeAlign: BorderSide.strokeAlignOutside,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20),
                  //       Wrap(
                  //         alignment: WrapAlignment.spaceAround,
                  //         spacing: 20,
                  //         children: forecast.map((item) {
                  //           return Column(
                  //             children: [
                  //               Text(item["temp"]!, style: AppTextstyle.textStyle20WhiteW600),
                  //               SizedBox(height: 8),
                  //               Image.asset(item["icon"]!, height: 60),
                  //               SizedBox(height: 8),
                  //               Text(item["time"]!, style: AppTextstyle.textStyle20WhiteW600),
                  //             ],
                  //           );
                  //         }).toList(),
                  //       ),
                  //       SizedBox(height: 16),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),SizedBox(height: 50,),
          Positioned(
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CityInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              ),
              child: Icon(Icons.search),
            ),
          ),
          Positioned(
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CityInfo()),
                );
              },style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            ),
              child: Icon(Icons.settings),
            ),
          ),Positioned(
            bottom:20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalPage()),
                );
              },
              label: Text("7-Days ForeCast"),
              icon: Icon(Icons.arrow_right_alt),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 35)
              ),
              // child: Icon(Icons.arrow_forward),
            ),
          ),
          if (loading)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:weather_app/city_info.dart';
// import 'package:weather_app/data/app_text_style.dart';
// import 'package:weather_app/final_page.dart';
// import 'package:weather_app/widgets/app_decoration.dart';
// import 'data/app_text.dart';
//
// class SecondScreen extends StatelessWidget {
//    SecondScreen({super.key});
//
//   final List<Map<String,String>> forecast = [
//     {"temp": "19°C","icon": "assets/images/sun_rain.png","time": "15:00"},
//     {"temp": "18°C","icon": "assets/images/Moon_cloud_mid_rain.png","time": "15:00"},
//     {"temp": "18°C","icon": "assets/images/sun_rain.png","time": "15:00"},
//     {"temp": "18°C","icon": "assets/images/sun_rain.png","time": "15:00"}
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [SingleChildScrollView(
//           child: Container(
//             // height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 244,
//                   height: 244,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/image1.png"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 4,),
//                 Text(
//                   AppText.deg,
//                   style: AppTextstyle.textStyle64WhiteW500,
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 52,),
//                 Text(
//                   AppText.precipitation,
//                   style: AppTextstyle.textStyle24WhiteW400,
//                   textAlign: TextAlign.center,
//                 ),
//                 Container(
//                   width: 336,
//                   height: 198,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/house.png"),
//                       fit: BoxFit.fill,
//                     )
//                   ),
//                 ),
//                 Container(
//                   width: 428,
//                   height: 246,
//                   decoration: AppDecoration.gradientBox,
//                   padding: EdgeInsets.all(16),
//                   child:Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Today",style: AppTextstyle.textStyle20WhiteW600,),
//                           Text("July, 21",style: AppTextstyle.textStyle20WhiteW600,),
//                         ],
//                       ),
//                       SizedBox(height: 20,),
//                       //Divider Line
//                       Container(
//                         width: 428,
//                         height: 0,
//                         decoration: ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(
//                                 width: 2,
//                                 color: Color(0xFF8D78C7),
//                                 strokeAlign:BorderSide.strokeAlignOutside,
//                               )
//                             )),
//                       ),
//                       SizedBox(height: 20,),
//                       //ForeCast Row
//                       Wrap(
//                         alignment: WrapAlignment.spaceAround,
//                         spacing: 20,
//                         children: forecast.map((item){
//                           return Column(
//                             children: [
//                             Text(item["temp"]!,style: AppTextstyle.textStyle20WhiteW600,),
//                             SizedBox(height: 8,),
//                               Image.asset(item["icon"]!,height: 60,),
//                               SizedBox(height: 8,),
//                               Text(item["time"]!,style: AppTextstyle.textStyle20WhiteW600,)
//                             ]
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(height: 16,),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 40,),
//               ],
//             ),
//           ),
//         ),
//           Positioned(
//             left: 20,
//               child: ElevatedButton(
//                 // backgroundColor: Colors.white,
//                 //   foregroundColor: Colors.black,
//                   onPressed: (){
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context)=>CityInfo())
//                   );
//                   },
//                 child: Icon(Icons.search),
//                  )
//           ),
//           Positioned(
//             right: 10,
//               child: ElevatedButton(
//                 // backgroundColor: Colors.white,
//                 //   foregroundColor: Colors.black,
//                   onPressed: (){
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context)=>CityInfo())
//                   );
//                   },
//                 child: Icon(Icons.settings),
//                  )
//           ),
//
//     ],
//       ),
//
//     );
//   }
// }
