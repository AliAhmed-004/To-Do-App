import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];

  // refer the box
  final myBox = Hive.box("myBox");

  //data for first time running the app
  void createInitialData() {
    toDoList = [
      ["Make app", false],
      ["Exercise", false],
    ];
  }

  //load data from db
  void loadData() {
    toDoList = myBox.get("TODOLIST");
  }

  //update database
  void updateDatabase() {
    myBox.put("TODOLIST", toDoList);
  }
}
