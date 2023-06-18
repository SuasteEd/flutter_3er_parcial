import 'package:examen_3er_parcial/models/task_model.dart';
import 'package:flutter/material.dart';
class DetailTask extends StatelessWidget {
const DetailTask({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final TaskModel args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Container();
  }
}