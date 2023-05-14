import 'package:flutter/material.dart';
import 'package:form_user_application/src/pages/form/add/add_user_page.dart';
import 'package:form_user_application/src/pages/form/list/list_user_page.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      title: "Creater user",
      getPages: [
        GetPage(name: '/', page: () => ListUserPage()),
        GetPage(name: '/addUser/form', page: () => const AddUserFormPage()),
      ],
    );
  }
}
