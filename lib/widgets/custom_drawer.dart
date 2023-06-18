import 'package:examen_3er_parcial/screens/screens.dart';
import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/data_controller.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _controller = Get.put(DataController());

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
            onTap: () {
              //final user = _controller.users.firstWhere((user) => user.email == );
              Get.to(RegisterScreen());
            }
          ),
          //Expanded(child: Container()),
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.logout, color: Colors.white),
            onTap: () {},
          ),
          
        ],
      ),
    );
  }
}
