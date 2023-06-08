import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../alerts/alert_error.dart';
import '../alerts/alert_successful.dart';
import '../controllers/data_controller.dart';
import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:examen_3er_parcial/widgets/custom_button.dart';
import 'package:examen_3er_parcial/widgets/custom_text_form_field.dart';
import 'package:examen_3er_parcial/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/user_model.dart';
// import 'package:get/get.dart';
// import '../widgets/custom_text_form_field.dart';

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _name = TextEditingController();
//   final _lastName = TextEditingController();
//   final _age = TextEditingController();
//   final _gender = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final _role = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isPressed = false;
//   // final _controller = Get.put(DataController());
//   @override
//   Widget build(BuildContext context) {
//     // final User? args = ModalRoute.of(context)?.settings.arguments as User?;
//     // if (args != null) {
//     //   _name.text = args.name;
//     //   _lastName.text = args.lastName;
//     //   _age.text = args.age.toString();
//     //   _gender.text = args.gender.toString();
//     //   _email.text = args.email;
//     //   _password.text = args.password;
//     //   _role.text = args.role;
//     // }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users Screen'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               const CustomCircleAvatar(
//                   tag: 'user', json: 'assets/json/user.json'),
//               const SizedBox(height: 20),
//               UserForm(
//                   genderFromList: args?.gender,
//                   roleFromList: args?.role,
//                   formKey: _formKey,
//                   name: _name,
//                   lastName: _lastName,
//                   age: _age,
//                   gender: _gender,
//                   email: _email,
//                   password: _password,
//                   role: _role),
//               CustomButton(
//                 text: _isPressed
//                     ? const LoadingButton()
//                     : Text(
//                         args == null ? 'Save' : 'Update',
//                         style: AppTheme.textButton,
//                       ),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _isPressed = true;
//                     final user = User(
//                         id: args?.id,
//                         name: _name.text,
//                         lastName: _lastName.text,
//                         age: int.parse(_age.text),
//                         gender: _gender.text,
//                         email: _email.text,
//                         password: _password.text,
//                         role: _role.text);
//                     if (args == null) {
//                       if (await _controller.addUser(user)) {
//                         _isPressed = false;
//                         setState(() {});
//                         // ignore: use_build_context_synchronously
//                         alertSucces(context, 'User saved successfully!');
//                       } else {
//                         _isPressed = false;
//                         setState(() {});
//                         // ignore: use_build_context_synchronously
//                         alertError(context, 'Error saving user!');
//                       }
//                     } else {
//                       if (await _controller.updateUser(user)) {
//                         _isPressed = false;
//                         setState(() {});
//                         // ignore: use_build_context_synchronously
//                         alertSucces(context, 'User updated successfully!');
//                       } else {
//                         _isPressed = false;
//                         setState(() {});
//                         // ignore: use_build_context_synchronously
//                         alertError(context, 'Error updating user!');
//                       }
//                     }
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController name,
    required TextEditingController lastName,
    required TextEditingController birthday,
    required TextEditingController email,
    required TextEditingController password,
  })  : _formKey = formKey,
        _name = name,
        _lastName = lastName,
        _birthday = birthday,
        _email = email,
        _password = password;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _name;
  final TextEditingController _lastName;
  final TextEditingController _birthday;
  final TextEditingController _email;
  final TextEditingController _password;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  // final TextEditingController birthday;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: widget._name,
            labelText: "Name",
            hintText: 'Enter your name',
            keyboardType: TextInputType.name,
            icon: Icons.person,
            obscureText: false,
            validationMessage: 'Please enter a name',
          ),
          // InkWell(
          //   onTap: () => showCustomDatePicker(context),
          //   child: CustomTextFormField(
          //       enabled: false,
          //       labelText: 'Birthday',
          //       hintText: '',
          //       icon: Icons.date_range,
          //       controller: widget._birthday,
          //       obscureText: false,
          //       validationMessage: 'Field is required',
          //       //onTap: () => showCustomDatePicker(context),
          //       keyboardType: TextInputType.name),
          // ),
          
          CustomTextFormField(
            controller: widget._email,
            labelText: "Email",
            hintText: 'Enter your email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            validationMessage: 'Please enter a valid email',
          ),
          CustomTextFormField(
            controller: widget._password,
            labelText: "Password",
            hintText: 'Enter your password',
            icon: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validationMessage: 'Please enter a password',
          ),
        ],
      ),
    );
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
    _birthday.text = DateFormat('dd/MM/yyyy').format(currentDate);
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _lastName = TextEditingController();
  final _birthday = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;
  DateTime? selectedDate;
  final DateTime currentDate = DateTime.now();
  final _controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    final User? args = ModalRoute.of(context)?.settings.arguments as User?;
    if (args != null) {
      _name.text = args.name;
      _birthday.text = args.birthday.toString();
      _email.text = args.email;
      _password.text = args.password;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 220,
                child: Lottie.asset('assets/json/people.json'),
              ),
              // Form(
              //   key: _formKey,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       CustomTextFormField(
              //         controller: _name,
              //         labelText: "Name",
              //         hintText: 'Enter your name',
              //         keyboardType: TextInputType.name,
              //         icon: Icons.person,
              //         obscureText: false,
              //         validationMessage: 'Please enter a name',
              //       ),
              //       CustomTextFormField(
              //         controller: _lastName,
              //         labelText: "Last Name",
              //         hintText: 'Enter your last name',
              //         keyboardType: TextInputType.name,
              //         obscureText: false,
              //         icon: Icons.person_outline,
              //         validationMessage: 'Please enter a last name',
              //       ),
              //       InkWell(
              //             onTap: () => showCustomDatePicker(context),
              //             child: CustomTextFormField(
              //                 enabled: false,
              //                 labelText: 'Birthday',
              //                 hintText: '',
              //                 icon: Icons.date_range,
              //                 controller: _birthday,
              //                 obscureText: false,
              //                 validationMessage: 'Field is required',
              //                 //onTap: () => showCustomDatePicker(context),
              //                 keyboardType: TextInputType.name),
              //           ),
              //       CustomTextFormField(
              //         controller: _email,
              //         labelText: "Email",
              //         hintText: 'Enter your email',
              //         icon: Icons.email,
              //         keyboardType: TextInputType.emailAddress,
              //         obscureText: false,
              //         validationMessage: 'Please enter a valid email',
              //       ),
              //       CustomTextFormField(
              //         controller: _password,
              //         labelText: "Password",
              //         hintText: 'Enter your password',
              //         icon: Icons.lock,
              //         obscureText: true,
              //         keyboardType: TextInputType.visiblePassword,
              //         validationMessage: 'Please enter a password',
              //       ),

              //     ],
              //   ),
              // ),
              UserForm(
                formKey: _formKey,
                name: _name,
                lastName: _lastName,
                birthday: _birthday,
                email: _email,
                password: _password,
              ),
              CustomButton(
                text: _isPressed
                    ? const LoadingButton()
                    : Text(
                        args == null ? 'Save' : 'Update',
                        style: AppTheme.textButton,
                      ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _isPressed = true;
                    final user = User(
                        id: args?.id,
                        name: _name.text,
                        birthday: _birthday.text,
                        email: _email.text,
                        password: _password.text);
                    if (args == null) {
                      if (await _controller.addUser(user)) {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertSucces(context, 'User saved successfully!');
                      } else {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertError(context, 'Error saving user!');
                      }
                    } else {
                      if (await _controller.updateUser(user)) {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertSucces(context, 'User updated successfully!');
                      } else {
                        _isPressed = false;
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        alertError(context, 'Error updating user!');
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
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
    _birthday.text = DateFormat('dd/MM/yyyy').format(currentDate);
  }
}
