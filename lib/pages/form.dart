import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/form_controller.dart';
import 'package:to_do_list_app/utils/app_colors.dart';
import 'package:to_do_list_app/widgets/form/add_task.dart';

class FormPage extends StatelessWidget {
  FormPage({super.key});

  final FormController controller = Get.find<FormController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
        title: Obx(
          () => Text(
            controller.isEditing.value ? 'Edit Task' : 'Add Task',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: AddTask(controller: controller),
          ),
        ),
      ),
    );
  }
}
