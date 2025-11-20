import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'weather_detail_screen.dart';

class FavoriteCityScreen extends StatefulWidget {
  const FavoriteCityScreen({super.key});

  @override
  State<FavoriteCityScreen> createState() => _FavoriteCityScreenState();
}

class _FavoriteCityScreenState extends State<FavoriteCityScreen> {
  final Box favoritesBox = Hive.box('favoritesBox');
  final TextEditingController cityController = TextEditingController();

  void addFavorite(String city) {
    favoritesBox.put(city, city);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> favoriteCities = favoritesBox.keys.cast<String>().toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      hintText: "Enter city name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    if (cityController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WeatherDetailScreen(city: cityController.text),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Favorite Cities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteCities.length,
                itemBuilder: (context, index) {
                  String city = favoriteCities[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(city),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          favoritesBox.delete(city);
                          setState(() {});
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WeatherDetailScreen(city: city)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cityController.text.isNotEmpty) {
            addFavorite(cityController.text);
            cityController.clear();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
