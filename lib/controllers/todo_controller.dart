import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list_app/models/todo_model.dart';

class TodoController extends GetxController {
  final storage = GetStorage();
  final RxList<TodoModel> todos = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  // Load todos from GetStorage
  void loadTodos() {
    try {
      final List<dynamic>? storedTodos = storage.read('todos');
      if (storedTodos != null) {
        todos.value = storedTodos
            .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      todos.value = [];
    }
  }

  // Save todos to GetStorage
  void saveTodos() {
    try {
      final List<Map<String, dynamic>> todosJson = todos
          .map((todo) => todo.toJson())
          .toList();
      storage.write('todos', todosJson);
    } catch (e) {
      todos.value = [];
    }
  }

  // Add new todo
  void addTodo({
    required String title,
    required String description,
    required String status,
    DateTime? deadline,
  }) {
    final newTodo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      status: status,
      createdAt: DateTime.now(),
      deadline: deadline,
    );

    todos.add(newTodo);
    saveTodos();
  }

  // Delete todo by id
  void deleteTodo(String id) {
    todos.removeWhere((todo) => todo.id == id);
    saveTodos();
  }

  // Update existing todo
  void updateTodo(TodoModel updatedTodo) {
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      saveTodos();
    }
  }

  // Get filtered todos based on status
  List<TodoModel> getFilteredTodos(String filter) {
    if (filter == 'all') {
      return todos;
    } else if (filter == 'todo') {
      return todos.where((todo) => todo.status == 'To do').toList();
    } else {
      return todos.where((todo) => todo.status == 'Done').toList();
    }
  }

  // Get count of filtered todos
  int getFilteredCount(String filter) {
    return getFilteredTodos(filter).length;
  }
}
