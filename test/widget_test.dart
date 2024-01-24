

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:tyskacz/Pages/AttractionPage.dart';


void main() {
  group('AttractionDescriptionPage Tests', () {
    // Sample Attraction object
    final sampleAttraction = Attraction(
      photoURL: 'https://bi.im-g.pl/im/3c/8e/f6/z16158268Q.jpg',
      name: 'Sample Attraction',
      description: 'This is a sample description', coordinates: LatLng(21,37),
    );

    testWidgets('renders Attraction elements with proper visibility and layout', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AttractionDescriptionPage(attraction: sampleAttraction)));

      // Verify that image, name, and description are displayed
      final nameFinder = find.text('Sample Attraction');
      final descriptionFinder = find.text('This is a sample description');

      expect(nameFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);

      // Check visibility and layout
      final nameTextWidget = tester.widget<Text>(nameFinder);
      final descriptionTextWidget = tester.widget<Text>(descriptionFinder);

      // Assert the text style, alignment, etc.
      expect(nameTextWidget.style?.fontSize, equals(25.0)); // Adjust the value as per your implementation
      expect(descriptionTextWidget.style?.fontSize, lessThanOrEqualTo(20.0)); // Example check

      expect(find.byType(IconButton), findsNWidgets(2));

      // Optionally, you can also check for text overflow
      expect(tester.takeException(), isNull);
    });
  });
}
