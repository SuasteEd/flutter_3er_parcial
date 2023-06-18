import 'package:examen_3er_parcial/models/tag_model.dart';
import 'package:examen_3er_parcial/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../services/firebase_service.dart';
import 'create_tag_screen.dart';

class Tags extends StatefulWidget {
  const Tags({super.key});

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  final _controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Header(
          title: "+ Add Tag",
          onPressed: () => Get.to(const CreateTagScreen()),),
          StreamBuilder(
            stream: FireBaseResponse().getTags(),
            builder: (_, snapshot) {
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
                                // final tag = _controller.tags
                                //     .firstWhere((e) => e.id == data[index].id);
                              final tag = TagModel(id: data[index].id,name: data[index]['name'], description: data[index]['description'], color: data[index]['color']);
                                
                                Get.to(() => CreateTagScreen(tag: tag));
                              },
                              child: Slidable(
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                          onPressed: (context) {
                                            _controller.deleteTag(
                                                data![index].id);
                                          },
                                          label: 'Delete',
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete
                                          ),
                                    ]),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: getColor(data![index].id),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(data[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text(data[index]['description']),
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
          },)
      ],
    );
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