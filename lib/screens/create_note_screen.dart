import 'package:examen_3er_parcial/controllers/data_controller.dart';
import 'package:examen_3er_parcial/widgets/custom_button.dart';
import 'package:examen_3er_parcial/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../alerts/alert_error.dart';
import '../alerts/alert_successful.dart';
import '../models/note_model.dart';
import '../models/tag_model.dart';
import '../theme/app_theme.dart';
import '../widgets/loading_button.dart';

class CreateNoteScreen extends StatefulWidget {
  final Note? note;
  const CreateNoteScreen({super.key, this.note});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

   void initData() {
    final task = widget.note;
    if (task != null) {
      _title.text = task.title;
      _description.text = task.description;
      _date.text = task.date;
      _tag.text = task.idTag;
    }
  }
  bool _isPressed = false;
  final _title = TextEditingController();
  final _date = TextEditingController();
  final _description = TextEditingController();
  final _tag = TextEditingController();
  final _controller = Get.put(DataController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("New Note")),
      body: Center(
        child: Column(
          children: [
            Lottie.asset('assets/json/note.json', height: 220),
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
                  ),
                  CustomTextFormField(
                    labelText: 'Description',
                    hintText: '',
                    icon: Icons.text_snippet,
                    controller: _description,
                    obscureText: false,
                    validationMessage: 'Field is required',
                    keyboardType: TextInputType.name,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Please select a tag' : null,
                      //Valores de argumentos
                      value: note == null
                          ? null
                          : _controller.tags.firstWhere(
                              (element) => element.id == note.idTag),

                      hint: const Text('Tag',
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
                          Icons.tag,
                          color: Colors.black,
                        ),
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _tag.text = value!.id.toString();
                          // widget._idv.text = value.id.toString();
                        });
                      },
                      items: _controller.tags.map((TagModel value) {
                        return DropdownMenuItem<TagModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                    ),
                  ),
                  InkWell(
                    onTap: () => showCustomDatePicker(context),
                    child: CustomTextFormField(
                        enabled: false,
                        labelText: 'Date',
                        hintText: '',
                        icon: Icons.date_range,
                        controller: _date,
                        obscureText: false,
                        validationMessage: 'Field is required',
                        keyboardType: TextInputType.name),
                  ),
                  CustomButton(
                      text: _isPressed
                          ? const LoadingButton()
                          : Text(
                              note == null ? 'Save' : 'Update',
                              style: AppTheme.textButton,
                            ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isPressed = !_isPressed;
                          });
                          post(note, context);
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> post(Note? note, BuildContext context) async {
    if (note == null) {
      final noteModel = Note(
          idUser: '',
          idTag: _tag.text,
          title: _title.text,
          description: _description.text,
          date: _date.text);
      if (await _controller.addNote(noteModel)) {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertSucces(context, 'Note saved successfully!');
      } else {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertError(context, 'Error saving Note!');
      }
    } else {
      final noteModel = Note(
          id: note.id,
          idUser: '',
          idTag: _tag.text,
          title: _title.text,
          description: _description.text,
          date: _date.text);
      // print("Args null");
      if (await _controller.updateNote(noteModel)) {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertSucces(context, 'Note updated successfully!');
      } else {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertError(context, 'Error updating Note!');
      }
    }
  }

  Future<void> showCustomDatePicker(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime minDate = DateTime(currentDate.year - 100);
    final DateTime maxDate = DateTime(currentDate.year + 100);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: minDate,
      lastDate: maxDate,
    );
    _date.text = DateFormat('dd/MM/yyyy').format(selectedDate!).toString();
  }
}
