import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/tabs/Settings/Settings.dart';
import 'package:todo_app/ui/home/tabs/TasksTab/TasksTab.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Widget> tabs = [
    TasksTab(),
    Settings()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 5
          )
        ),
        onPressed: () {

      },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle() ,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          } ,
          currentIndex: selectedIndex,
          backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ] ,),
      ),
      body: tabs[selectedIndex] ,
    );
  }
}
