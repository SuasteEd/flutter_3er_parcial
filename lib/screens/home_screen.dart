// import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:examen_3er_parcial/screens/screens.dart';
import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../services/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    const Tasks(),
    const Notes(),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white),
      //drawer: Drawer(),
      // body: CustomScrollView(
      //   slivers: [
      //     CustomAppBar(),
      //     SliverList(
      //       delegate: SliverChildListDelegate([
      //          SizedBox(
      //                 height: size.height * 0.05,
      //                 child: ListView.builder(
      //                   itemCount: 10,
      //                   itemBuilder: (_, i) {
      //                   return Container(
      //                     height: 100,
      //                     width: 100,
      //                     color: Colors.red,
      //                   );
      //                 }),
      //               ),
      //       ]),
      //     ),
      //   ],
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.hourglass_bottom),
              title: const Text('Tasks'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.done),
              title: const Text('Notes'),
              selectedColor: Colors.white,
            ),
          ]),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);
  void navigateToSearchScreen(String query) {
    //Navigator.pushNamed(context, '', arguments: query);
  }
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      //title: Text('Tasks'),
      automaticallyImplyLeading: false,
      //expandedHeight: 130,
      expandedHeight: size.height * 0.2,

      pinned: true,
      flexibleSpace: Container(
        color: AppTheme.secondary,
        child: FlexibleSpaceBar(
            centerTitle: true,
            expandedTitleScale: 1,
            titlePadding: const EdgeInsets.only(bottom: 8),
            title: const Text('Tasks', style: AppTheme.textButton),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Lottie.asset('assets/json/splash.json'),
                    ),
                    const SizedBox(width: 15),
                    const Text('Welcome\n to Your ToDo',
                        style: AppTheme.textButton),
                  ],
                ),
              ],
            )
            //Lottie.asset('assets/json/splash.json', fit: BoxFit.scaleDown),
            ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset('assets/json/splash.json'),
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'ToDo',
//                   style: AppTheme.textButton,
//                 )),
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Notes',
//                   style: AppTheme.textButton,
//                 )),
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Tags',
//                   style: AppTheme.textButton,
//                 )),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppTheme.secondary,
//         onPressed: () {},
//         child: Icon(Icons.settings),
//       ),
//     );
//   }
// }

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          title: '+ Add Task',
          onPressed: () => Get.to(const CreateTaskScreen()),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (_, i) {
              return InkWell(
                onTap: () => print('Hola'),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  //width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TAG',
                            style: AppTheme.textTitle.copyWith(fontSize: 16),
                          ),
                          //IconButton(onPressed: (){}, icon: Icon(Icons.))
                          Checkbox(
                            value: _isSelected,
                            onChanged: (value) {
                              _isSelected = value!;
                              setState(() {});
                            },
                            activeColor: AppTheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                      Text(
                        'Title',
                        style: AppTheme.textTitle,
                      ),
                      Text(
                        'Description',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const textStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24);
    return Container(
      height: size.height * 0.22,
      //color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.secondary, width: 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Welcome\n to Your ToDo', style: AppTheme.textTitle),
              CircleAvatar(
                radius: 30,
                child: Lottie.asset('assets/json/splash.json'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    'May 30, 2023',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text('Today', style: textStyle),
                ],
              ),
              MaterialButton(
                onPressed: onPressed,
                color: AppTheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Header(
            title: '+ Add Notes',
            onPressed: () {},
          ),
          StreamBuilder(
              stream: FireBaseResponse().getUsers(),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                return Center(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TAG',
                                          style: AppTheme.textTitle
                                              .copyWith(fontSize: 16),
                                        ),
                                        //IconButton(onPressed: (){}, icon: Icon(Icons.))
                                        Checkbox(
                                          value: _isSelected,
                                          onChanged: (value) {
                                            _isSelected = value!;
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
                                      'Title',
                                      style: AppTheme.textTitle,
                                    ),
                                    Text(
                                      'Description',
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
                );
              }),
        ],
      ),
    );
  }
}
