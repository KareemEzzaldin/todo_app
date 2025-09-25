import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/firestore/FireStoreHandler.dart';
import 'package:todo_app/style/reusable_components/CustomLodingDialog.dart';
import 'package:todo_app/style/reusable_components/CustomMessageDialog.dart';
import 'package:todo_app/style/reusable_components/constants.dart';

import '../../../../../firestore/model/Task.dart';

class Taskitem extends StatelessWidget {
  final Task task;
  const Taskitem({required this.task});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Slidable(
      startActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(onPressed: (context) {
              // Delete Task
              DeleteTask(context);
            },
              backgroundColor: Colors.red,
              label: "Delete",
              icon: Icons.delete,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              ),
            )
          ],),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: height*0.08,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(width: width*0.05,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title??"",
                    maxLines: 1, // max number of line
                    overflow: TextOverflow.ellipsis, // to add (...) if the title is more than 1 line
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary),),
                  Text(task.description??"", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500),),
                ],
              ),
            ), // we put expanded so we can give the title and des its own space in case if it was to big so I doesn't mess the icon
            // Spacer(), // used to put space between items
            ElevatedButton(onPressed: () {

            }, child: Icon(Icons.check))
          ],
        ),
      ),
    );
  }
  DeleteTask(BuildContext context){
    showDialog(context: context, builder: (context) => CustomMessageDialog(
        message: "Are you sure you want to delete this task ?",
        positiveBtnTitle: "Yes",
        positiveBtnPress: () async {
          showDialog(context: context, builder: (context) => CustomLodingDialog(),);
          await FireStoreHandler.DeleteTask(FirebaseAuth.instance.currentUser!.uid, task.id??""); // widget.task.id??''
          Navigator.pop(context);
          ShowToast("Task Deleted Successfully");
          Navigator.pop(context);
        },
        negativeBtnTitle: "No",
        negativeBtnPress: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
