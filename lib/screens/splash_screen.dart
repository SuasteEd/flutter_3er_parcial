import 'package:examen_3er_parcial/controllers/data_controller.dart';
import 'package:examen_3er_parcial/controllers/shared_prefs.dart';
import 'package:examen_3er_parcial/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _shared = SharedPrefs();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (_shared.isLogin) {
        await Get.put(DataController()).getAllTags();
        await Get.put(DataController()).getAllUsers();
        Get.to(() => const HomeScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 2));
      } else {
        Get.to(() => const LoginScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 2));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/json/splash.json'),
      ),
    );
  }
}
