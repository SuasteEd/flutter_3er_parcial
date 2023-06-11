import 'package:flutter/material.dart';

class CreateTagScreen extends StatefulWidget {
  const CreateTagScreen({super.key});

  @override
  State<CreateTagScreen> createState() => _CreateTagScreenState();
}

class _CreateTagScreenState extends State<CreateTagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Tag"),
      ),
    );
  }
}