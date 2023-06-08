import '../controllers/data_controller.dart';
import '../models/tag_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/loading_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final _tag = TextEditingController();
  final _controller = Get.put(DataController());
  final _date = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  final DateTime currentDate = DateTime.now();
  final _priority = ['Low', 'Medium', 'High'];
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
                          keyboardType: TextInputType.name),
                      CustomTextFormField(
                          labelText: 'Description',
                          hintText: '',
                          icon: Icons.text_snippet,
                          controller: _description,
                          obscureText: false,
                          validationMessage: 'Field is required',
                          keyboardType: TextInputType.name),
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
                            //onTap: () => showCustomDatePicker(context),
                            keyboardType: TextInputType.name),
                      ),
                      // CustomTextFormField(
                      //     labelText: 'Tag',
                      //     hintText: '',
                      //     icon: Icons.tag,
                      //     controller: _description,
                      //     obscureText: false,
                      //     validationMessage: '',
                      //     keyboardType: TextInputType.name),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? 'Please select a tag' : null,
                          //value: _controller.args,

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
                      // DatePickerDialog(
                      //     initialDate: currentDate,
                      //     firstDate: DateTime(currentDate.year - 100),
                      //     lastDate: DateTime(currentDate.year + 100)),
                      CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // _controller.createTask(
                              //     title: _title.text,
                              //     description: _description.text);
                              // Get.back();
                            }
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

  Future<void> showCustomDatePicker(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime minDate = DateTime(currentDate.year - 100);
    final DateTime maxDate = DateTime(currentDate.year + 100);

    selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: minDate,
      lastDate: maxDate,
    );
    _date.text = DateFormat('dd/MM/yyyy').format(currentDate);
  }
}
