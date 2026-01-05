import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/form_controller.dart';
import 'package:to_do_list_app/utils/app_colors.dart';
import 'package:to_do_list_app/widgets/common/custom_text_field.dart';

class AddTask extends StatelessWidget {
  final FormController controller;

  const AddTask({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller.titleController,
              label: "Title",
              hint: "Enter your title",
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller.descriptionController,
              label: "Description",
              hint: "Enter your description",
              maxLines: 3,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 20),
            Text(
              "Status",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: SegmentedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.accent;
                      }
                      return Colors.white;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white;
                      }
                      return AppColors.textPrimary;
                    }),
                    side: WidgetStatePropertyAll(BorderSide.none),
                  ),
                  segments: [
                    ButtonSegment(
                      value: 'To do',
                      label: Text('To do', style: TextStyle(fontSize: 15)),
                    ),
                    ButtonSegment(
                      value: 'Done',
                      label: Text('Done', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                  selected: {controller.category.value},
                  onSelectionChanged: (value) {
                    controller.category.value = value.first;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller.deadlineController,
              label: "Deadline",
              hint: "mm/dd/yyyy",
              readOnly: true,
              onTap: () => controller.selectDate(context),
              prefixIcon: Icons.calendar_today_outlined,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  controller.submitForm();
                },
                child: Obx(
                  () => Text(
                    controller.isEditing.value ? "Update Task" : "Add Task",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
