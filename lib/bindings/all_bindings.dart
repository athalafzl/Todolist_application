import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/filtering_controller.dart';
import 'package:to_do_list_app/controllers/form_controller.dart';
import 'package:to_do_list_app/controllers/todo_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
    Get.lazyPut(() => FilteringController());
    Get.lazyPut(() => FormController(), fenix: true);
  }
}
