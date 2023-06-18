import 'package:examen_3er_parcial/models/tag_model.dart';
import 'package:examen_3er_parcial/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../alerts/alert_error.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/loading_button.dart';

class CreateTagScreen extends StatefulWidget {
  final TagModel? tag;
  const CreateTagScreen({super.key, this.tag});

  @override
  State<CreateTagScreen> createState() => _CreateTagScreenState();
}

class _CreateTagScreenState extends State<CreateTagScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.tag != null) {
      _name.text = widget.tag!.name;
      _description.text = widget.tag!.description;
      _color.text = widget.tag!.color;
    }
  }
  final List<String> _colores = [
    'Rojo',
    'Azul',
    'Verde',
    'Amarillo',
    'Morado',
    'Rosa',
    'Naranja',
    'Cafe',
    'Gris'
  ];
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _color = TextEditingController();
  final _controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    final tag = widget.tag;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Tag"),
      ),
      body: Center(
        child: Column(children: [
          Lottie.asset('assets/json/task.json', height: 220),
          Form(
              key: _formKey,
              child: Column(
            children: [
              CustomTextFormField(
                  labelText: 'Name',
                  hintText: 'Name',
                  icon: Icons.person,
                  controller: _name,
                  obscureText: false,
                  validationMessage: 'Please enter a name',
                  keyboardType: TextInputType.name),
              CustomTextFormField(
                  labelText: 'Description',
                  hintText: 'Description',
                  icon: Icons.text_snippet,
                  controller: _description,
                  obscureText: false,
                  validationMessage: 'Please enter a description',
                  keyboardType: TextInputType.name),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DropdownButtonFormField(
                  validator: (value) =>
                      value == null ? 'Please select a color' : null,
                  //Valores de argumentos de prioridad
                  //value: task?.priority,
                  value: tag == null ? null : _color.text[0].toUpperCase() + _color.text.substring(1),
                  hint: const Text('Color',
                      style: TextStyle(color: Colors.black)),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    prefixIconColor: Colors.black,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    //contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(
                      Icons.color_lens,
                      color: Colors.black,
                    ),
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _color.text = value.toString();
                    });
                  },
                  items: _colores.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
          CustomButton(
            text: _isPressed
                ? const LoadingButton()
                : Text(
                    tag == null ? 'Save' : 'Update',
                    style: AppTheme.textButton,
                  ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isPressed = !_isPressed;
                });
                await post(tag, context);
              }
            },
          )
        ]),
      ),
    );
  }

  Future<void> post(TagModel? tag, BuildContext context) async {
    if (tag == null) {
      final tagModel = TagModel(
          id: tag?.id,
          name: _name.text,
          description: _description.text,
          color: _color.text.toLowerCase());
      if (await _controller.addTag(tagModel)) {
        _isPressed = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        alertSucces(context, 'Task saved successfully!');
      } else {
        _isPressed = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        alertError(context, 'Error saving Task!');
      }
    } else {
      final tagModel = TagModel(
          id: tag.id,
          name: _name.text,
          description: _description.text,
          color: _color.text.toLowerCase());
      // print("Args null");
      if (await _controller.updateTag(tagModel)) {
        _isPressed = false;
        // setState(() {});
        // ignore: use_build_context_synchronously
        alertSucces(context, 'Task updated successfully!');
      } else {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertError(context, 'Error updating Task!');
      }
    }
  }
}
