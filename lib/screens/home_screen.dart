import 'package:examen_3er_parcial/screens/tasks.dart';
import 'package:examen_3er_parcial/theme/app_theme.dart';
import 'package:examen_3er_parcial/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'notes.dart';
import 'tags.dart';

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
    const Tags()
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: CustomDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.task_alt_outlined),
              title: const Text('Tasks'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.format_list_bulleted_outlined),
              title: const Text('Notes'),
              selectedColor: Colors.white,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.tag),
              title: const Text('Tags'),
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MMM-yyyy – kk:mm').format(now);
    final size = MediaQuery.of(context).size;
    const textStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24);
    return Container(
      height: size.height * 0.17,
      //color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.secondary, width: 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                children:  [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const Text('Today', style: textStyle),
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
