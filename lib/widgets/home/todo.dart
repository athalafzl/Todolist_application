import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/filtering_controller.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/utils/app_colors.dart';
import 'package:to_do_list_app/widgets/home/todo_item_card.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    final FilteringController filteringController =
        Get.find<FilteringController>();
    final TodoController todoController = Get.find<TodoController>();

    return Expanded(
      child: Obx(() {
        final filter = filteringController.all.value
            ? 'all'
            : filteringController.todo.value
            ? 'todo'
            : 'done';
        final filteredTodos = todoController.getFilteredTodos(filter);

        if (filteredTodos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.task_alt,
                    size: 64,
                    color: AppColors.primary.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'No tasks yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Start by adding a new task to your list',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 80,
            top: 10,
          ), // Add padding for FAB
          itemCount: filteredTodos.length,
          itemBuilder: (context, index) {
            final todo = filteredTodos[index];
            return TodoItemCard(todo: todo, todoController: todoController);
          },
        );
      }),
    );
  }
}
