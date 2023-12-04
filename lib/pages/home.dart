import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/data/database.dart';
import 'package:tic_tac_toe/util/newTask.dart';
import 'package:tic_tac_toe/util/toDoTile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDoDatbase db = ToDoDatbase();
  final myBox = Hive.box("myBox");

  @override
  void initState() {
    // TODO: implement initState
    //if first time ever opening app, create default data
    if(myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    else {
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();


  //Method for checkbox tapped
  void checkBoxChanged(bool? value, index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save method
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //creating new task
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return NewTask(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff700),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 5,
        backgroundColor: Color(0xfffff063),
        centerTitle: true,
        title: Text(
          "Your To Dos",
          style: TextStyle(
              color: Color(0xff474747),
              letterSpacing: 5,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xfffffb7a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.home),
              label: Text("Home"))
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            deleteFunction: (context) => deleteTask(index),
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color(0xfffffc9c),
      ),
    );
  }
}
