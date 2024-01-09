class TaskModel {
  String? id;
  String  taskText;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskText,
    this.isDone = false,
  });

  static List<TaskModel> toDoList() {
    return [
      TaskModel(id: '01', taskText: 'Estudar'),
      TaskModel(id: '02', taskText: 'Arrumar o quarto', isDone: true)
    ];
  }
}
