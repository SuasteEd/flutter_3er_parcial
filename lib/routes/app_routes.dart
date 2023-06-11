import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/' : (_) => const SplashScreen(),
    'login': (_) => LoginScreen(),
    'register': (_) => RegisterScreen(),
    'detailTask': (_) => DetailTask(),
    'notes': (_) =>  Notes(),
    'menu': (_) =>  HomeScreen()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}