import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/theme.dart';
// import 'package:weather_app/data/theme.dart';

class CityInfo extends StatefulWidget {
  const CityInfo({super.key});

  @override
  State<CityInfo> createState() => _CityInfoState();
}

class _CityInfoState extends State<CityInfo> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool loading = false;

  // List to store searched cities with temperature
  List<Map<String, dynamic>> searchedCities = [];

  Future<void> fetchWeather(String city) async {
    setState(() => loading = true);

    final apiKey = "a8590b5f50206eb6ea2e472e69d2eb4f";
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          weatherData = data;
          loading = false;

          // Add to searchedCities list
          searchedCities.add({
            "city": data["name"],
            "temp": data["main"]["temp"],
            "icon": data["weather"][0]["icon"],
            "description": data["weather"][0]["description"]
          });
        });
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("City not found!")),
        );
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error fetching weather")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Info"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x8A2A604B), Color(0xffccc5da), Color(0xff9d52ac)],
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        fetchWeather(_cityController.text.trim());
                        _cityController.clear();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Center(child: bodyContent()),
              loading ? const CircularProgressIndicator() : weatherData == null ? const Text(
                "Search any city to see weather",
                style: TextStyle(fontSize: 18),
              )
                  : Column(
                children: [
                  Text(
                    "${weatherData!["name"]} - ${weatherData!["main"]["temp"]}°C",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    "https://openweathermap.org/img/wn/${weatherData!["weather"][0]["icon"]}@2x.png",
                      height: 100,
                      color: Colors.white
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: searchedCities.length,
                  itemBuilder: (context, index) {
                    final city = searchedCities[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          "https://openweathermap.org/img/wn/${city["icon"]}@2x.png",
                          width: 50,
                        ),
                        title: Text("${city["city"]}"),
                        subtitle: Text(
                            "${city["temp"]}°C - ${city["description"]}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              searchedCities.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//   Widget bodyContent() {
//     if (loading) return const CircularProgressIndicator();
//     if (weatherData == null) return const Text("Search any city to see weather", style: TextStyle(fontSize: 18));
//
//     return Column(
//       children: [
//         Text(
//           "${weatherData!["name"]} - ${weatherData!["main"]["temp"]}°C",
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class CityInfo extends StatefulWidget {
//   const CityInfo({super.key});
//
//   @override
//   State<CityInfo> createState() => _CityInfoState();
// }
//
// class _CityInfoState extends State<CityInfo> {
//   final TextEditingController _cityController = TextEditingController();
//   Map<String, dynamic>? weatherData;
//   bool loading = false;
//
//   Future<void> fetchWeather(String city) async {
//     setState(() => loading = true);
//
//     final apiKey = "a8590b5f50206eb6ea2e472e69d2eb4f";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
//
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         setState(() {
//           weatherData = jsonDecode(response.body);
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("City not found!")),
//         );
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching weather")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Weather Info",),
//         backgroundColor: Colors.deepPurpleAccent,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0x8A2A604B), Color(0xffccc5da), Color(0xff9d52ac)],
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [SizedBox(height: 10,width: 2,),
//               TextField(
//                 controller: _cityController,
//                 decoration: InputDecoration(
//                   hintText: "Enter city name",
//                   suffixStyle:TextStyle(color: Colors.black),
//                   hintStyle: TextStyle(color: Colors.white),
//                   labelStyle: TextStyle(color: Colors.white),
//                   suffixIconColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(
//                       color: Colors.teal
//                     )
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () {
//                       if (_cityController.text.isNotEmpty) {
//                         fetchWeather(_cityController.text.trim());
//                       }
//                     },
//                   ),
//                 ),
//
//               ),
//
//               const SizedBox(height: 20),
//
//               loading
//                   ? const CircularProgressIndicator()
//                   : weatherData == null
//                   ? const Text(
//                 "Search any city to see weather",
//                 style: TextStyle(
//                     fontSize: 18,
//                     color:Colors.white,
//                 ),
//               )
//                   : Column(
//                 children: [
//                   Text(
//                     "${weatherData!["name"]}",
//                     style: const TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "${weatherData!["main"]["temp"]}°C",
//                     style: const TextStyle(
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                         color: Colors.white
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Image.network(
//                     "https://openweathermap.org/img/wn/${weatherData!["weather"][0]["icon"]}@2x.png",
//                       height: 100,
//                       color: Colors.white
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     weatherData!["weather"][0]["description"],
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w500,
//                         color: Colors.white
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }