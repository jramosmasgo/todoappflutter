import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_friend/src/screens/add_todo_screen.dart';
import 'package:todo_friend/src/views/add_task_view.dart';
import 'package:todo_friend/src/views/home_view.dart';
import 'package:todo_friend/src/views/search_task_view.dart';
import 'package:todo_friend/src/views/settings_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final views = [
      const HomeView(),
      const AddTaskView(),
      const SearchTaskView(),
      const SettingsView()
    ];

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: IndexedStack(
        index: selectedIndex,
        children: views,
      )),
      floatingActionButton: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).go('/add');
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          fixedColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'List',
            ),
          ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 70,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLD0WJi3ePhxARZFzZBxEe92XxAk4ALD_qig&s'),
          ),
        ),
      ]),
    );
  }
}
