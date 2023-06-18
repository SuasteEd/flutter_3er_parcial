import 'package:animate_do/animate_do.dart';
import 'package:examen_3er_parcial/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../models/note_model.dart';
import '../services/firebase_service.dart';
import '../theme/app_theme.dart';
import 'create_note_screen.dart';
import 'home_screen.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Header(
            title: '+ Add Notes',
            onPressed: () => Get.to(const CreateNoteScreen()),
          ),
          StreamBuilder(
              stream: FireBaseResponse().getNotes(),
              builder: (context, snapshot) {
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
                                  // final note = _controller.notes.firstWhere(
                                  //     (e) => e.id == data[index].id);
                                  final note = Note(
                                      id: data[index].id,
                                      title: data[index]['title'],
                                      description: data[index]['description'],
                                      idUser: '',
                                      idTag: data[index]['idTag'],
                                      date: data[index]['date']);
                                  Get.to(
                                    CreateNoteScreen(
                                      note: note,
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
                                                  .deleteNote(data![index].id);
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
                                            padding: const EdgeInsets.all(8),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: getColor(
                                                      data![index]['idTag'])
                                                  .withOpacity(0.9),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                            ),
                                            child: Text(
                                              getTagTitle(data[index]['idTag']),
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
                                                    data[index]
                                                            ['description'] ??
                                                        '',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const Spacer(),
                                                Text(data[index]['date'] ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
      ),
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
