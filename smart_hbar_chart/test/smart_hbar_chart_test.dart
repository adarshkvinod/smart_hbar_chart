import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_hbar_chart/smart_hbar_chart.dart';

void main() {
  testWidgets('SmartBarGraph renders correctly', (WidgetTester tester) async {
    // Sample data
    final testData = [
      SmartBarData(
          label: 'A', value: 50, imageUrl: 'https://example.com/img1.png'),
      SmartBarData(
          label: 'B', value: 80, imageUrl: 'https://example.com/img2.png'),
    ];

    // Define test style
    final testStyle = SmartBarStyle(
      barHeight: 20,
      barBorderRadius: 8,
      barGradientColors: [Colors.blue, Colors.blueAccent],
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmartBarGraph(
            data: testData,
            maxValue: 100,
            style: testStyle,
          ),
        ),
      ),
    );

    // Verify that the labels are rendered
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);

    // Verify the values are displayed
    expect(find.text('50 KG'), findsOneWidget);
    expect(find.text('80 KG'), findsOneWidget);

    // Verify the ruler is displayed
    expect(find.text('0KG'), findsOneWidget);
    expect(find.text('100KG'), findsOneWidget);

    // Verify bars are present
    final bars = find.byType(Container);
    expect(bars, findsWidgets);

    // Trigger animation
    await tester.pumpAndSettle();

    // Check that animation completed
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });

  testWidgets('SmartBarGraph calls custom image builder',
      (WidgetTester tester) async {
    bool imageBuilderCalled = false;

    Widget customImageBuilder(String imageUrl) {
      imageBuilderCalled = true;
      return const Icon(Icons.image);
    }

    final testData = [
      SmartBarData(
          label: 'C', value: 30, imageUrl: 'https://example.com/img3.png'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmartBarGraph(
            data: testData,
            maxValue: 100,
            imageBuilder: customImageBuilder,
          ),
        ),
      ),
    );

    expect(imageBuilderCalled, isTrue);
  });
}
