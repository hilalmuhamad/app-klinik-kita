// main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/rekam_medis_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/kesehatan_saya_screen.dart';

void main() {
  runApp(MeditechApp());
}

class MeditechApp extends StatelessWidget {
  const MeditechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/medical-history': (context) => const RekamMedisScreen(),
        '/profile': (context) => ProfileScreen(),
        '/kesehatan-saya': (context) => const KesehatanSayaScreen(),
      },
    );
  }
}
