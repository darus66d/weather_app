import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String city;
  const WeatherDetailScreen({super.key, required this.city});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  final Box weatherBox = Hive.box('weatherBox');
  String? temperature;
  bool isCelsius = true;
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  void loadWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    String fetchedTemp = "${20 + widget.city.length}°C"; // Simulated

    // Save current temp
    weatherBox.put(widget.city, fetchedTemp);

    // Save history
    history = weatherBox.get('${widget.city}_history', defaultValue: []).cast<String>();
    history.add(fetchedTemp);
    weatherBox.put('${widget.city}_history', history);

    setState(() {
      temperature = fetchedTemp;
    });
  }

  String toggleUnit(String temp) {
    if (temp.contains('°C') && !isCelsius) {
      double c = double.parse(temp.replaceAll('°C', ''));
      return "${(c * 9/5 + 32).toStringAsFixed(1)}°F";
    } else if (temp.contains('°F') && isCelsius) {
      double f = double.parse(temp.replaceAll('°F', ''));
      return "${((f - 32) * 5/9).toStringAsFixed(1)}°C";
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (temperature != null)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff3d2c8e), Color(0xff533595), Color(0xff9d52ac)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.wb_sunny, size: 60, color: Colors.yellow),
                    const SizedBox(height: 16),
                    Text(
                      toggleUnit(temperature!),
                      style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCelsius = !isCelsius;
                        });
                      },
                      child: const Text("Toggle °C/°F"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 20),
            const Text("History:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
