import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/filtering_controller.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/utils/app_colors.dart';

class Filtering extends GetView<FilteringController> {
  const Filtering({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find<TodoController>();

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildFilterChip(
              label: 'All',
              count: todoController.getFilteredCount('all'),
              isSelected: controller.all.value,
              onSelected: (val) => controller.changeFilter('all'),
            ),
            const SizedBox(width: 12),
            _buildFilterChip(
              label: 'To do',
              count: todoController.getFilteredCount('todo'),
              isSelected: controller.todo.value,
              onSelected: (val) => controller.changeFilter('todo'),
            ),
            const SizedBox(width: 12),
            _buildFilterChip(
              label: 'Done',
              count: todoController.getFilteredCount('done'),
              isSelected: controller.done.value,
              onSelected: (val) => controller.changeFilter('done'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required int count,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return ChoiceChip(
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      selectedColor: AppColors.accent,
      backgroundColor: Colors.white,
      onSelected: onSelected,
      elevation: isSelected ? 2 : 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.3),
    );
  }
}
