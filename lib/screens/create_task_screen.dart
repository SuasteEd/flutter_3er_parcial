import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:examen_3er_parcial/widgets/custom_button.dart';
import 'package:examen_3er_parcial/widgets/custom_text_form_field.dart';
import 'package:examen_3er_parcial/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  bool _isPressed = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('New Task'),
        ),
        body: Center(
          child: Column(
            children: [
              Lottie.asset('assets/json/task.json', height: 220),
              Form(
                  child: Column(
                children: [
                  CustomTextFormField(
                      labelText: 'Title',
                      hintText: '',
                      icon: Icons.title,
                      controller: _title,
                      obscureText: false,
                      validationMessage: '',
                      keyboardType: TextInputType.name),
                  CustomTextFormField(
                      labelText: 'Description',
                      hintText: '',
                      icon: Icons.text_snippet,
                      controller: _description,
                      obscureText: false,
                      validationMessage: '',
                      keyboardType: TextInputType.name),
                  CustomTextFormField(
                      labelText: 'Tag',
                      hintText: '',
                      icon: Icons.tag,
                      controller: _description,
                      obscureText: false,
                      validationMessage: '',
                      keyboardType: TextInputType.name),
                  CustomButton(
                      onPressed: () {
                        _isPressed = !_isPressed;
                        setState(() {});
                      },
                      text: _isPressed
                          ? const LoadingButton()
                          : const Text(
                              'Crear',
                              style: AppTheme.textButton,
                            ))
                ],
              ))
            ],
          ),
        ));
  }
}
