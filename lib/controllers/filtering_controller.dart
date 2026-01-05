import 'package:get/get.dart';

class FilteringController extends GetxController {
  RxBool all = true.obs;
  RxBool todo = false.obs;
  RxBool done = false.obs;

  void changeFilter(String filter) {
    if (filter == 'all') {
      all.value = true;
      todo.value = false;
      done.value = false;
    } else if (filter == 'todo') {
      all.value = false;
      todo.value = true;
      done.value = false;
    } else {
      all.value = false;
      todo.value = false;
      done.value = true;
    }
  }
}
