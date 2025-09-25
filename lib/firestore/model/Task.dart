import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  static const String collectionName = "Task";
  String? id;
  String? title;
  String? description;
  Timestamp? date;
  late bool isDone; // I added the late cause the second Constructor can't see that I gave it initial value false
  Task({this.id,this.title, this.description, this.date, this.isDone = false});

  // Task.formFireStore(Map<String, dynamic> data){
  //   id = data?["id"];
  //   title = data?["title"];
  //   description = data?["description"];
  //   date = data?["date"];
  //   isDone = data?["isDone"];
  // }

  // factory Task.formFireStore(Map<String, dynamic> data) {
  //   return Task(
  //     id: data["id"],
  //     title: data["title"],
  //     description: data["description"],
  //     date: data["date"],
  //     isDone: data["isDone"] ?? false,
  //   );
  // }

  factory Task.formFireStore(Map<String, dynamic> data, {required id}) {
    return Task(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      date: data["date"],
      isDone: data["isDone"] ?? false,
    );
  }


  Map<String, dynamic>toFireStore(){
    return {
      "id" : id,
      "title" : title,
      "description" : description,
      "date" : date,
      "isDone" : isDone
    };
  }
}