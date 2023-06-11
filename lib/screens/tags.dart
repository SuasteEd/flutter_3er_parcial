import 'package:examen_3er_parcial/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_tag_screen.dart';

class Tags extends StatefulWidget {
  const Tags({super.key});

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Header(
          title: "+ Add Tag",
          onPressed: () => Get.to(const CreateTagScreen()),)
      ],
    );
  }
}