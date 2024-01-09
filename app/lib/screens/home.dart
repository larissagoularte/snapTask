import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/task.dart';
import '../model/task-model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskList = TaskModel.toDoList();
  List<TaskModel> _foundTask = [];
  final _taskController = TextEditingController();

  @override
  void initState() {
    _foundTask = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'Todas as tarefas',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (TaskModel todo in _foundTask)
                        Task(
                          todo: todo,
                          onTaskChanged: _handleTaskChange,
                          onTaskDeleted: _deleteTask,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                              hintText: 'Adicionar nova tarefa',
                              border: InputBorder.none),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        onPressed: () {
                          _addTask(_taskController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: stLightPurple,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        )),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _handleTaskChange(TaskModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTask(String id) {
    setState(() {
      taskList.removeWhere((task) => task.id == id);
    });
  }

  void _addTask(String task) {
    setState(() {
      taskList.add(TaskModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          taskText: task));
    });
    _taskController.clear();
  }

  void _searchTask(String string) {
    List<TaskModel> results = [];
    if (string.isEmpty) {
      results = taskList;
    } else {
      results = taskList
          .where((task) =>
              task.taskText!.toLowerCase().contains(string.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTask = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _searchTask(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: stBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Pesquisar',
          hintStyle: TextStyle(color: stGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 100,
      title: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'snap',
                style: TextStyle(
                  color: stLightPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            TextSpan(
              text: 'Task',
              style: TextStyle(
                color: stDarkerPurple,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        //'snapTask',
        //tyle: TextStyle(fontSize: 43, fontWeight: FontWeight.w500),
      ),
      backgroundColor: stBGColor,
      elevation: 0,
      foregroundColor: stDarkerPurple,
    );
  }
}
