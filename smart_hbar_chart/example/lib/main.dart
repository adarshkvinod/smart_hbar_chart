// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:smart_hbar_chart/smart_hbar_chart.dart'; // Import the smart_hbar_chart package

void main() {
  // Run the Flutter application with MyApp as the root widget
  runApp(const MyApp());
}

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the main configuration widget for the app
    return MaterialApp(
      title: 'Smart HBar Chart Demo', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color theme
      ),
      home: const MyHomePage(), // Set the home page of the app
    );
  }
}

// MyHomePage is the main page of the app
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart HBar Chart Demo'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: SmartBarGraph(
          // SmartBarGraph is a custom widget for displaying horizontal bar charts
          data: [
            // List of SmartBarData objects representing the bars in the chart
            SmartBarData(
              label: 'Product A', // Label for the bar
              value: 75, // Value determining the length of the bar
              imageUrl:
                  'https://picsum.photos/200', // URL for the image associated with the bar
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
          maxValue: 100, // Maximum value for the bar chart (used for scaling)
          style: const SmartBarStyle(
            barGradientColors: [
              Colors.blue,
              Colors.green
            ], // Gradient colors for the bars
            barHeight: 32, // Height of each bar
          ),
        ),
      ),
    );
  }
}
