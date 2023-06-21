import 'package:examen_3er_parcial/controllers/shared_prefs.dart';
import 'package:examen_3er_parcial/screens/screens.dart';
import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/data_controller.dart';
import '../services/firebase_auth.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _auth = Auth();
  final _prefs = SharedPrefs();
  final _controller = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppTheme.primary,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          Lottie.asset(
            'assets/json/login.json',
            width: 200,
            height: 200,
          ),
          ListTile(
           title: const Text('My profile', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.person, color: Colors.white),
            onTap: () async {
              final user = _controller.users.firstWhere((e) => e.id == _prefs.uid);
              Get.to(RegisterScreen(user: user,));
            }
          ),
          //Expanded(child: Container()),
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.logout, color: Colors.white),
            onTap: () async {
              await _auth.logout();
              _prefs.clean();
              Get.offAllNamed('login');
            },
          ),
          
        ],
      ),
    );
  }
}
