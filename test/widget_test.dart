import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tyskacz/Pages/AuthorisationPages/changePassword.dart';
import 'package:tyskacz/Pages/AuthorisationPages/signIn.dart';
import 'package:tyskacz/Pages/AuthorisationPages/signUp.dart';

void main() {
  group('SignIn Widget Tests', () {
    testWidgets('UI Elements are Rendered', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      // Check if the logo is displayed
      expect(find.byType(Image), findsOneWidget);

      // Check if the 'Sign In' title is displayed
      expect(find.text('Sign In'), findsOneWidget);

      // Check if input fields are displayed
      expect(find.widgetWithText(TextField, 'Login'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

      // Check if 'Forgot password?' and 'Don't have an account?' buttons are displayed
      expect(find.text('Change password'), findsOneWidget);
      expect(find.text('Create an account'), findsOneWidget);

      // Check if the 'Log in' button is displayed
      expect(find.widgetWithText(ElevatedButton, 'Log in'), findsOneWidget);
    });

    testWidgets('Navigation to Change Password Page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      await tester.tap(find.text('Change password'));
      await tester.pumpAndSettle(); // Wait for navigation animation

      // Check if the Change Password Page is displayed
      expect(find.byType(ChangePassword), findsOneWidget);
    });

    testWidgets('Navigation to Sign Up Page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      // Tap the 'Don't have an account?' button
      await tester.tap(find.text('Create an account'));
      await tester.pumpAndSettle(); // Wait for navigation animation

      // Check if the Sign Up Page is displayed
      expect(find.byType(SignUp), findsOneWidget);
    });

    // You can add more test cases for user interactions, button clicks, etc.
  });
}
