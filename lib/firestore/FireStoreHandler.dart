import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/Task.dart';
import 'model/User.dart' show User;

class FireStoreHandler {
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~User~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // to call a function in a static function it must be static as well
  static getUserCollecton(){
    var firestore = FirebaseFirestore.instance;
    var collection = firestore.collection(User.collection).withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return User.formFirestore(data);
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }
  // I made the function static so I can call it by the class name
  static Future<void> creatUser(User user){
    // add new user as document in firestor
    var collection = getUserCollecton();
    var docRef =  collection.doc(user.ID); // I made this code so I can make a doc in firestore with the same ID of the user
    return docRef.set(user); // take my data and put in the doc
  }
  static Future<User?> readUser(userID)async{
    var collection = getUserCollecton();
    var docRef =  collection.doc(userID);
    var docSnapShot = await docRef.get();
    return docSnapShot.data();
  }
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Task~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//   static getTaskCollection(String userID){
//     // make a task collection inside each user
//     var collection = getUserCollecton().doc(userID).collection(Task.collectionName).withConverter(
//         fromFirestore : (snapshot, options) => Task.formFireStore(snapshot.data()),
//         toFirestore : (value, options) => value.toFireStore());
//     return collection;
// }


  static getTaskCollection(String userID) {
    return getUserCollecton()
        .doc(userID)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
          Task.formFireStore(snapshot.data()!, id: snapshot.id,),
          toFirestore: (Task task, SetOptions? options) =>
          task.toFireStore(),
    );
  }




  // static Future<void> creatTask(Task task, String userID){
  //     var collection =  getTaskCollection(userID);
  //     var docRef = collection.doc();
  //     task.id = docRef.id;
  //     return docRef.set(task);
  // }

  static Future<void> creatTask(Task task, String userID) {
    var collection = getTaskCollection(userID);
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  // static Future<List<Task>> GetTasks(String userID)async{
  //    var collection = getTaskCollection(userID);
  //    var tasksQuerySnapShot = await collection.get();
  //    var listTaskSnapShot = tasksQuerySnapShot.docs;
  //    var taskList = listTaskSnapShot.map((snapshot) =>snapshot.data()).toList();
  //    return taskList;
  // }


  static Future<List<Task>> GetTasks(String userID) async {
    var collection = getTaskCollection(userID);
    var tasksQuerySnapShot = await collection.get();
    List<Task> taskList = tasksQuerySnapShot.docs
        .map<Task>((QueryDocumentSnapshot<Task> snapshot) => snapshot.data())
        .toList();
    return taskList;
  }

  // static Stream<List<Task>> GetTasksListen(String userID) async* { // async* cause of yiled
  //   var collection = getTaskCollection(userID);
  //   var tasksQuerySnapShot =  collection.snapshots();
  //   var listTaskStream = tasksQuerySnapShot.map((querySnapshot) => querySnapshot.docs.map((document) =>document.data).toString());
  //   yield* listTaskStream ; // yield to listen not return
  // }

  static Stream<List<Task>> GetTasksListen(String userID, DateTime selectedDate) async* {
    // I made dateOnly to match the date here in the date in firebase which has 00:00:00 to solve the logic error of the tasks not appearing
    DateTime dateOnly = selectedDate.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      millisecond: 0,
    );
    var collection = getTaskCollection(userID).where(
      "date", isEqualTo : Timestamp.fromDate(dateOnly) // to transfer from DateTime to Timestamp
    );
    var snapshots = collection.snapshots();

    yield* snapshots.map<List<Task>>((QuerySnapshot<Task> querySnapshot) {
      return querySnapshot.docs
          .map<Task>((QueryDocumentSnapshot<Task> doc) => doc.data())
          .toList();
    });
  }



  static Future<void >DeleteTask(String userID, String taskID){
    var collection = getTaskCollection(userID);
    return collection.doc(taskID).delete();
  }

  static Future<void> updateTask(
      String taskID, Task task, String userID) async {
    var collection = getTaskCollection(userID);
    await collection.doc(taskID).update(task.toFireStore());
  }


  static Future<void> updateTaskIsDone(
      String userID, String taskID, bool isDone) async {
    var collection = getTaskCollection(userID);
    await collection.doc(taskID).update({"isDone": isDone});
  }

  static Future<void> markTaskDone(String userID, String taskID) {
    var collection = getTaskCollection(userID);
    return collection.doc(taskID).update({
      "isDone": true,
    });
  }


}