import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/home/presentation/bloc/driver_home_bloc.dart';
import 'features/profile/presentation/bloc/captain_profile_bloc.dart';
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => ServiceLocator.createAuthBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => ServiceLocator.createDashboardBloc(),
        ),
        BlocProvider<DriverHomeBloc>(
          create: (_) => ServiceLocator.createDriverHomeBloc(),
        ),
        BlocProvider<CaptainProfileBloc>(
          create: (_) => ServiceLocator.createCaptainProfileBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Captain Partner Portal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const LoginPage(),
      ),
    );
  }
}
