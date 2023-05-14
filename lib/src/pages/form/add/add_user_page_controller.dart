import 'dart:async';

import 'package:flutter/material.dart';

import 'package:form_user_application/src/models/user/controller/user_controller.dart';
import 'package:form_user_application/src/models/user/model_user/model_user.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddUserPageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressesController = TextEditingController();

  void submitForm(BuildContext context, List<String> addresses) async {
    final name = nameController.text;
    final lastName = lastNameController.text;
    final birthDate = birthDateController.text;
    //final addresses = addressesController.text.split(',');

    if (isValidForm(name, lastName, birthDate, addresses)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 20, msg: 'Registrando Usuario');
      await Future.delayed(const Duration(seconds: 1));
      progressDialog.close();

      User user = User(name, lastName, DateTime.parse(birthDate), addresses);

      final userController = Get.find<UserController>();
      userController.addUser(user);
      nameController.clear();
      lastNameController.clear();
      birthDateController.clear();
      addressesController.clear();

      Navigator.pop(context);
    } else {
      Get.snackbar('Formulario No valido', 'Debes Ingresar todos los datos');
      return;
    }
  }

  void logout() {
    Get.offNamedUntil('/', (route) => false);
  }

  bool isValidForm(
      String name, String lastName, String birthDate, List addresses) {
    if (name.isEmpty || lastName.isEmpty || addresses.isEmpty) {
      Get.snackbar('Formulario No valido', 'Debes Ingresar todos los datos');

      return false;
    }

    if (birthDate == null) {
      Get.snackbar(
          'Formulario no Valido', 'Debes agregar la fecha de Nacimiento');

      return false;
    }

    return true;
  }
}
