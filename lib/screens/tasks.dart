import 'package:flutter/material.dart';
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
  bool _isSelected = false;
  final _controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
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
                  height: _size.height * 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => print('Hola'),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: const EdgeInsets.all(10),
                                height: _size.height * 0.14,
                                //width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color:
                                                getColor(data![index]['idTag']),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              // data != null
                                              //     ? data[index]['title']
                                              //     : '',
                                              getTagTitle(data[index]['idTag']),
                                              // FireBaseResponse()
                                              //     .getUsers()
                                              //     .toString()[index][1],
                                              style: AppTheme.textTitle
                                                  .copyWith(fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        //IconButton(onPressed: (){}, icon: Icon(Icons.))
                                        Checkbox(
                                          value: _isSelected,
                                          onChanged: (value) {
                                            _isSelected = value!;
                                            //getColor(data![index]['idTag']);
                                            setState(() {});
                                          },
                                          activeColor: AppTheme.secondary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      data[index]['title'] ?? '',
                                      style: AppTheme.textTitle,
                                    ),
                                    Text(
                                      data[index]['description'] ?? '',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
        // StreamBuilder(
        //     stream: FireBaseResponse().getUsers(),
        //     builder: (context, snapshot) {
        //       final data = snapshot.data?.docs;
        //       if (!snapshot.hasData) {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //       if (snapshot.hasError) {
        //         return const Center(child: Text('Something went wrong'));
        //       }
        // return ListView(
        //   children: <Widget>[
        //     // ListTile es un widget que funciona como un bloque del ListView
        //     ListTile(
        //       // Tiene muchas propiedades que nos ayudan a ordenar la información.
        //       // Titulo
        //       title: Text('Primero'),
        //       // Subtitulo
        //       subtitle: Text('Este es el primer Tile'),
        //       // Icono inicial del bloque
        //       leading: Icon(Icons.add),
        //       // Funcion que se ejecuta al hacer click en él
        //       onTap: () {},
        //     ),
        //     ListTile(
        //       title: Text('Primero'),
        //       onTap: () {},
        //     )
        //   ],
        // );
        // }),
      ],
    );
  }

  String getTagTitle(String id) {
    //final color = _controller.tags.where((e) => e.id == id).toList();
    //return color[0].color;
    final color = _controller.tags.firstWhere((e) => e.id == id);
    return color.name;
  }

  Color getColor(String id) {
    final color = _controller.tags.firstWhere((e) => e.id == id);
    switch (color.color) {
      case 'rojo':
        return Colors.red;
    }
    return Colors.transparent;
  }
}
