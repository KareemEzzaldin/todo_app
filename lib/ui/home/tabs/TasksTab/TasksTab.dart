import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firestore/FireStoreHandler.dart';
import 'package:todo_app/ui/home/tabs/TasksTab/Widgets/TaskItem.dart';

import '../../../../firestore/model/Task.dart';

class TasksTab extends StatelessWidget {
  DateTime selectedDate;
  TasksTab({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>( // <List<Task>> I used Stream so when any changes happens in the firebase it changes here also without restarting
        stream: FireStoreHandler.GetTasksListen(FirebaseAuth.instance.currentUser!.uid, selectedDate),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            // Handler loading logic
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            // Handler an error logic
            return Column(
              children: [
                Text(snapshot.error.toString()),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Try Again")),
              ],
            );
          }
          // handler logic of success
          List<Task> tasks = snapshot.data??[];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 20,),
              itemCount: tasks.length,
              itemBuilder: (context, index) => Taskitem(task: tasks[index]) ,
            ),
          );
        },
    );
  }
}
