import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/widgets/home/filtering_home.dart';
import 'package:to_do_list_app/widgets/home/todo.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';
import 'package:to_do_list_app/controllers/form_controller.dart';
import 'package:to_do_list_app/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            "My Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          bottom: todoController.todos.isEmpty
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Filtering(),
                  ),
                ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [const SizedBox(height: 16), ToDoList()]),
          ),
        ),
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: Color(0x4D4F39F6),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              Get.find<FormController>().clearForm();
              Get.toNamed("/form");
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
