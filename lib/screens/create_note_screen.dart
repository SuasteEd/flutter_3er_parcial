import 'package:examen_3er_parcial/controllers/data_controller.dart';
import 'package:examen_3er_parcial/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  bool _isPressed = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _tag = TextEditingController();
  final _controller = Get.put(DataController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Note")
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset('assets/json/login.json', height: 220),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Title',
                    hintText: '',
                    icon: Icons.title,
                    controller: _title,
                    obscureText: false,
                    validationMessage: 'Field is required',
                    keyboardType: TextInputType.name,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
