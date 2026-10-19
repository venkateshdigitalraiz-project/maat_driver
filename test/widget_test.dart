import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driver/features/dashboard/presentation/pages/driver_dashboard_page.dart';
import 'package:driver/injection_container.dart';
import 'package:driver/main.dart';

void main() {
  setUp(() {
    ServiceLocator.init();
  });

  testWidgets('LoginPage renders correctly and shows phone input', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Driver Portal'), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);
  });

  testWidgets('DriverDashboardPage renders Home and navigates to Profile tab', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ServiceLocator.createDashboardBloc()),
          BlocProvider(create: (_) => ServiceLocator.createDriverHomeBloc()),
          BlocProvider(create: (_) => ServiceLocator.createCaptainProfileBloc()),
        ],
        child: const MaterialApp(
          home: DriverDashboardPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Home Tab elements
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text("Today's Earnings"), findsOneWidget);
    expect(find.text('ONLINE'), findsOneWidget);

    // Tap Profile Tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify Profile Tab elements
    expect(find.text('Captain Profile'), findsOneWidget);
    expect(find.text('Captain Payout Wallet'), findsOneWidget);
  });
}
