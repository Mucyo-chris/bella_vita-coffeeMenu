import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bella_vita/app.dart';

void main() {
  Widget buildApp() => const ProviderScope(child: BellaVitaApp());

  // ── Splash ────────────────────────────────────────────────
  testWidgets('Splash screen shows app name', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(); // first frame

    expect(find.text('Bella Vita'), findsWidgets);
  });

  // ── Login ─────────────────────────────────────────────────
  testWidgets('Login screen renders email field and Next button',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());

    // Skip splash delay
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    // Email / phone field placeholder should be visible
    expect(find.text('Email or phone'), findsOneWidget);

    // Next and Create Account buttons
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });

  testWidgets('Login shows error when Next tapped with empty field',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    // Tap Next without entering anything
    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(find.text('This field is required'), findsOneWidget);
  });

  testWidgets('Login navigates to main tab after entering email',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(CupertinoTextField), 'test@bellavita.app');
    await tester.tap(find.text('Next'));

    // Wait for async sign-in (700ms simulated delay)
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // Should land on Home tab — Good Morning label visible
    expect(find.text('Good Morning'), findsOneWidget);
  });

  // ── Sign Up ───────────────────────────────────────────────
  testWidgets('Sign Up screen renders all four fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);
  });

  testWidgets('Sign Up shows validation errors when submitted empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    // Tap Sign Up without filling anything
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(find.text('This field is required'), findsWidgets);
  });

  // ── Home / Coffee ──────────────────────────────────────────
  testWidgets('Home screen shows category chips after login',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(CupertinoTextField), 'user@bellavita.app');
    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    expect(find.text('ALL'), findsOneWidget);
    expect(find.text('Espresso'), findsOneWidget);
    expect(find.text('Cappuccino'), findsOneWidget);
    expect(find.text('Americano'), findsOneWidget);
  });

  // ── Cart ──────────────────────────────────────────────────
  testWidgets('Cart tab shows empty state when no items added',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(CupertinoTextField), 'user@bellavita.app');
    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // Tap the Shop / Cart tab (index 2)
    await tester.tap(find.text('Shop'));
    await tester.pumpAndSettle();

    expect(find.text('Your cart is empty'), findsOneWidget);
  });
}