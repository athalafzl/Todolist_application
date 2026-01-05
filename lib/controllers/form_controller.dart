import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/models/todo_model.dart';

class FormController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deadlineController = TextEditingController();
  RxString category = 'To do'.obs;
  Rx<DateTime?> selectedDeadline = Rx<DateTime?>(null);
  RxBool isEditing = false.obs;
  String? editingId;

  final TodoController todoController = Get.find<TodoController>();

  void setEditingTodo(TodoModel todo) {
    isEditing.value = true;
    editingId = todo.id;
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    category.value = todo.status;
    if (todo.deadline != null) {
      selectedDeadline.value = todo.deadline;
      deadlineController.text =
          "${todo.deadline!.year}-${todo.deadline!.month.toString().padLeft(2, '0')}-${todo.deadline!.day.toString().padLeft(2, '0')}";
    }
  }

  // Method to select date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDeadline.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDeadline.value) {
      selectedDeadline.value = picked;
      deadlineController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void submitForm() {
    // Validate inputs
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Title cannot be empty',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Description cannot be empty',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (isEditing.value) {
      // Update existing todo
      final originalTodo = todoController.todos.firstWhere(
        (element) => element.id == editingId,
      );
      final newTodo = originalTodo.copyWith(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: category.value,
        deadline: selectedDeadline.value,
      );

      todoController.updateTodo(newTodo);

      Get.snackbar(
        margin: EdgeInsets.all(10),
        'Task updated!',
        "${titleController.text.trim()} updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: Icon(Icons.check, color: Colors.green.shade700),
      );
    } else {
      // Add new todo
      todoController.addTodo(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        status: category.value,
        deadline: selectedDeadline.value,
      );

      Get.snackbar(
        margin: EdgeInsets.all(10),
        'Task created!',
        '${titleController.text.trim()} added successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: Icon(Icons.check, color: Colors.green.shade700),
      );
    }

    // Clear form
    clearForm();

    // Navigate back to home
    Get.offAllNamed('/home');
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    deadlineController.clear(); // Clear deadline controller
    selectedDeadline.value = null; // Reset selected deadline
    category.value = 'To do';
    isEditing.value = false;
    editingId = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose(); // Dispose deadline controller
    super.onClose();
  }
}
