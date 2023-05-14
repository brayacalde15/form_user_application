import 'package:flutter/material.dart';

import 'package:form_user_application/src/models/user/controller/user_controller.dart';
import 'package:form_user_application/src/pages/form/list/list_user_page_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListUserPage extends StatelessWidget {
  ListUserPageController controller = Get.put(ListUserPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Usuarios',
          style: GoogleFonts.ubuntu(
              textStyle: const TextStyle(fontSize: 20),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () {
          final user = Get.put(UserController());
          final userController = Get.find<UserController>();
          final users = userController.users;
          if (users.isEmpty) {
            const Center(child: Text("No hay Usuarios Registrados"));
          } else {}
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          user.firstName.substring(0, 1),
                          style: GoogleFonts.ubuntu(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      title: Text(
                        '${user.firstName} ${user.lastName} ${DateFormat('dd-MM-yyyy').format(user.birthDate)} ',
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                      ),
                      subtitle: Text(
                        "Direccion:${user.addresses.join(',  ')} ",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 112, 107, 107)),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goToaddUserPage(),
        child: const Icon(
          Icons.person_add,
          size: 30,
        ),
      ),
    );
  }
}
