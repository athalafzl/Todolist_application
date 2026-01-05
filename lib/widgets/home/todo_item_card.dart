import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/controllers/form_controller.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/models/todo_model.dart';
import 'package:to_do_list_app/utils/app_colors.dart';

class TodoItemCard extends StatelessWidget {
  final TodoModel todo;
  final TodoController todoController;

  const TodoItemCard({
    super.key,
    required this.todo,
    required this.todoController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  elevation: WidgetStatePropertyAll(2),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.more_horiz, color: AppColors.textSecondary),
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit_outlined,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Edit Task',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Delete',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.delete,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Delete Task',
                          style: TextStyle(color: AppColors.delete),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'Edit') {
                    final formController = Get.find<FormController>();
                    formController.setEditingTodo(todo);
                    Get.toNamed('/form');
                  } else if (value == 'Delete') {
                    _showDeleteDialog(context);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            todo.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusChip(),
              if (todo.deadline != null) _buildDateChip(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    final isDone = todo.status == 'Done';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDone
            ? Colors.green.withValues(alpha: 0.1)
            : AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        todo.status,
        style: TextStyle(
          fontSize: 12,
          color: isDone ? Colors.green : AppColors.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateChip() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 14,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          DateFormat('MMM d, y').format(todo.deadline!),
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Task',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              todoController.deleteTodo(todo.id);
              Get.back();
              Get.snackbar(
                'Task Deleted',
                '${todo.title} has been removed.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.white,
                colorText: AppColors.textPrimary,
                icon: const Icon(Icons.delete_outline, color: AppColors.delete),
                margin: const EdgeInsets.all(10),
                borderRadius: 12,
                boxShadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppColors.delete,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
