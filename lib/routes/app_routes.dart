import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/' : (_) => const SplashScreen(),
    'login': (_) => const LoginScreen(),
    'register': (_) => const RegisterScreen(),
    'detailTask': (_) => const DetailTask(),
    'createTask': (_) => const CreateTaskScreen(),
    'notes': (_) =>  const Notes(),
    'menu': (_) =>  const HomeScreen()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}