import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityInfo extends StatefulWidget {
  const CityInfo({super.key});

  @override
  State<CityInfo> createState() => _CityInfoState();
}

class _CityInfoState extends State<CityInfo> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool loading = false;

  Future<void> fetchWeather(String city) async {
    setState(() => loading = true);

    final apiKey = "a8590b5f50206eb6ea2e472e69d2eb4f"; // এখানে তোমার API Key বসাও
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          loading = false;
        });
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("City not found!")),
        );
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching weather")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Info"),
        backgroundColor: Colors.deepPurpleAccent,
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
              colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SizedBox(height: 2,width: 0,),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        fetchWeather(_cityController.text.trim());
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              loading
                  ? const CircularProgressIndicator()
                  : weatherData == null
                  ? const Text(
                "Search any city to see weather",
                style: TextStyle(fontSize: 18),
              )
                  : Column(
                children: [
                  Text(
                    "${weatherData!["name"]}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${weatherData!["main"]["temp"]}°C",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Image.network(
                    "https://openweathermap.org/img/wn/${weatherData!["weather"][0]["icon"]}@2x.png",
                    height: 100,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    weatherData!["weather"][0]["description"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
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