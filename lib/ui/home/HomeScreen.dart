import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/tabs/Settings/Settings.dart';
import 'package:todo_app/ui/home/tabs/TasksTab/TasksTab.dart';
import 'package:todo_app/ui/home/widgets/AddTaskBottomSheet.dart';
import 'package:todo_app/ui/login/LoginScreen.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  DateTime selectedDate = DateTime.now();
  // List<Widget> tabs = [
  //   TasksTab(),
  //   Settings()
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 5
          )
        ),
        onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AddTaskBottomSheet(),);
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
          currentIndex: selectedIndex ,
          backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ] ,),
      ),

      // I put the app bar here so I can treat it as a widget and put another widget on it
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, // to ensure nothing gets cut if it moved after limits
            alignment: Alignment.bottomCenter,
            children: [
              AppBar(
                title: Text("To Do List"),
                actions: [
                  IconButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false,);
                  },
                      icon: Icon(Icons.logout)),
                ],
              ),
              // I wrapped the container with positioned so I can move it as I like an put the bottom with (-) so it moves after limits
              Visibility(
                visible: selectedIndex==0,
                child: Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: EasyInfiniteDateTimeLine(
                    showTimelineHeader: false,
                    dayProps: EasyDayProps(
                      width: 58,
                      height: 79,
                      dayStructure: DayStructure.dayNumDayStr,
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        )
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    focusDate: selectedDate,
                    onDateChange: (NewDate) {
                      // Handle the selected date.
                      setState(() {
                        selectedDate = NewDate;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          // since I got only 2 tabs I can do this
          Expanded(child: selectedIndex==0
              ?TasksTab(selectedDate: selectedDate)
              :Settings()),
        ],
      ) ,
    );
  }
}
