import 'package:animate_do/animate_do.dart';
import 'package:examen_3er_parcial/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../services/firebase_service.dart';
import '../theme/app_theme.dart';
import 'create_task_screen.dart';
import 'home_screen.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final _controller = Get.put(DataController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Header(
          title: '+ Add Task',
          onPressed: () => Get.to(const CreateTaskScreen()),
        ),
        StreamBuilder(
            stream: FireBaseResponse().getTasks(),
            builder: (_, snapshot) {
              //Variable que almacena la información de la base de datos
              final data = snapshot.data?.docs;
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              return Center(
                child: SizedBox(
                  height: size.height * 0.65,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                // final task = _controller.tasks
                                //     .firstWhere((e) => e.id == data[index].id);
                                //final task = TaskModel(idUser: data[], tag: tag, title: title, description: description, date: date, isCompleted: isCompleted, priority: priority)

                                //print(_controller.tasks.first.id);
                                final task = TaskModel(
                                    id: data[index].id,
                                    idUser: '',
                                    tag: data[index]['idTag'],
                                    title: data[index]['title'],
                                    description: data[index]['description'],
                                    date: data[index]['date'],
                                    isCompleted: data[index]['isCompleted'],
                                    priority: data[index]['priority']);
                                Get.to(
                                  CreateTaskScreen(
                                    task: task,
                                  ),
                                );
                              },
                              child: Slidable(
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                          onPressed: (context) {
                                            _controller
                                                .deleteTask(data![index].id);
                                          },
                                          label: 'Delete',
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete),
                                    ]),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                getColor(data![index]['idTag'])
                                                    .withOpacity(0.9),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                  '  ${getTagTitle(data[index]['idTag'])}'),
                                              const Spacer(),
                                              Checkbox(
                                                value: data[index]
                                                        ['isCompleted'] ??
                                                    false,
                                                onChanged: (value) {
                                                  _controller
                                                      .postTaskIsCompleted(
                                                          value!,
                                                          data[index].id);
                                                  //getColor(data![index]['idTag']);
                                                  setState(() {});
                                                },
                                                activeColor: AppTheme.secondary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index]['title'] ?? '',
                                                style: AppTheme.textTitle,
                                              ),
                                              Text(
                                                  data[index]['description'] ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                      data[index]['date'] ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const Spacer(),
                                                  Text(
                                                      data[index]['priority'] ??
                                                          '',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  String getTagTitle(String id) {
    final name = _controller.tags.firstWhere((e) => e.id == id);
    return name.name;
  }

  Color getColor(String id) {
    final color = _controller.tags.firstWhere((e) => e.id == id);
    switch (color.color) {
      case 'rojo':
        return Colors.red;
      case 'azul':
        return Colors.blue;
      case 'verde':
        return Colors.green;
      case 'amarillo':
        return Colors.yellow;
      case 'morado':
        return Colors.purple;
      case 'rosa':
        return Colors.pink;
      case 'naranja':
        return Colors.orange;
      case 'cafe':
        return Colors.brown;
      case 'gris':
        return Colors.grey;
    }
    return Colors.transparent;
  }
}
