import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list_app/pages/form.dart';
import 'package:to_do_list_app/pages/home.dart';
import 'package:to_do_list_app/bindings/all_bindings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/utils/app_colors.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
      initialBinding: AllBindings(),
      getPages: [
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/form", page: () => FormPage()),
      ],
    );
  }
}
