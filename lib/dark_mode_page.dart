import 'package:flutter/material.dart';
import 'data/theme_controller.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({super.key});

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  int selected = 2; // Default: System

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dark mode"),
      ),
      body: Column(
        children: [
          RadioListTile(
            value: 0,
            groupValue: selected,
            title: const Text("Off"),
            onChanged: (value) {
              setState(() => selected = value!);
              MyTheme.setLight();
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: selected,
            title: const Text("On"),
            onChanged: (value) {
              setState(() => selected = value!);
              MyTheme.setDark();
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: selected,
            title: const Text("System"),
            onChanged: (value) {
              setState(() => selected = value!);
              MyTheme.setSystem();
            },
          ),
        ],
      ),
    );
  }
}
