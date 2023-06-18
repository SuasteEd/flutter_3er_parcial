import 'package:examen_3er_parcial/models/task_model.dart';

import '../alerts/alert_error.dart';
import '../alerts/alert_successful.dart';
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
  final TaskModel? task;
  const CreateTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    final task = widget.task;
    if (task != null) {
      _title.text = task.title;
      _description.text = task.description;
      _date.text = task.date;
      _tag.text = task.tag;
      _prioritySelected.text = task.priority;
    }
  }

  bool _isPressed = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _tag = TextEditingController();
  final _prioritySelected = TextEditingController();
  final _controller = Get.put(DataController());
  final _date = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _priority = ['Low', 'Medium', 'High'];
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: DropdownButtonFormField(
                          
                          validator: (value) =>
                              value == null ? 'Please select a tag' : null,
                          //Valores de argumentos
                          value: task == null
                              ? null
                              : _controller.tags.firstWhere(
                                  (element) => element.id == task.tag),
                          
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? 'Please select a priority' : null,
                          //Valores de argumentos de prioridad
                          value: task?.priority,
                          hint: const Text('Priority',
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
                              Icons.low_priority,
                              color: Colors.black,
                            ),
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _prioritySelected.text = value.toString();
                            });
                          },
                          items: _priority.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      CustomButton(
                        text: _isPressed
                            ? const LoadingButton()
                            : Text(
                                task == null ? 'Save' : 'Update',
                                style: AppTheme.textButton,
                              ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                           setState(() {
                              _isPressed = !_isPressed;
                           });
                            await post(task, context);
                          }
                        },
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<void> post(TaskModel? task, BuildContext context) async {
    if (task == null) {
      final taskModel = TaskModel(
          id: task?.id,
          date: _date.text,
          description: _description.text,
          tag: _tag.text,
          idUser: "FP3TGakq6FZYASWj91hY",
          isCompleted: task?.isCompleted ?? false,
          priority: _prioritySelected.text,
          title: _title.text);
      if (await _controller.addTask(taskModel)) {
        _isPressed = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        alertSucces(
            context, 'Task saved successfully!');
      } else {
        _isPressed = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        alertError(context, 'Error saving Task!');
      }
    } else {
      final taskModel = TaskModel(
          id: task.id,
          date: _date.text,
          description: _description.text,
          tag: _tag.text,
          idUser: "FP3TGakq6FZYASWj91hY",
          isCompleted: task.isCompleted,
          priority: _prioritySelected.text,
          title: _title.text);
      // print("Args null");
      if (await _controller.updateTask(taskModel)) {
        _isPressed = false;
        // setState(() {});
        // ignore: use_build_context_synchronously
        alertSucces(
            context, 'Task updated successfully!');
      } else {
        setState(() {
          _isPressed = false;
        });
        // ignore: use_build_context_synchronously
        alertError(context, 'Error updating Task!');
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
