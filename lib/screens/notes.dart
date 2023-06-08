import 'package:examen_3er_parcial/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_service.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _controller = Get.put(DataController());
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Header(
            title: '+ Add Notes',
            onPressed: () {},
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
                    height: _size.height * 0.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => print('Hola'),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  height: 200,
                                  //width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: getColor(
                                                  data![index]['idTag']),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                // data != null
                                                //     ? data[index]['title']
                                                //     : '',
                                                getTagTitle(
                                                    data[index]['idTag']),
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
                                          // Checkbox(
                                          //   value: _isSelected,
                                          //   onChanged: (value) {
                                          //     _isSelected = value!;
                                          //     //getColor(data![index]['idTag']);
                                          //     setState(() {});
                                          //   },
                                          //   activeColor: AppTheme.secondary,
                                          //   shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(10)),
                                          // )
                                        ],
                                      ),
                                      Text(
                                        data != null
                                            ? data[index]['title']
                                            : '',
                                        style: AppTheme.textTitle,
                                      ),
                                      Text(
                                        data != null
                                            ? data[index]['description']
                                            : '',
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
    }
    return Colors.transparent;
  }
}
