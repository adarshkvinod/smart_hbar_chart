// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:smart_hbar_chart/smart_hbar_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart HBar Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart HBar Chart Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SmartBarGraph(
          data: [
            SmartBarData(
              label: 'Product A',
              value: 75,
              imageUrl: 'https://picsum.photos/200', // placeholder image
            ),
            SmartBarData(
              label: 'Product B',
              value: 45,
              imageUrl: 'https://picsum.photos/200',
            ),
            SmartBarData(
              label: 'Product C',
              value: 90,
              imageUrl: 'https://picsum.photos/200',
            ),
          ],
          maxValue: 100,
          style: const SmartBarStyle(
            barGradientColors: [Colors.blue, Colors.green],
            barHeight: 32,
          ),
        ),
      ),
    );
  }
}
