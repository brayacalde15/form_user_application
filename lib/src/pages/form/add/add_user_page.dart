import 'package:flutter/material.dart';

import 'package:form_user_application/src/pages/form/add/add_user_page_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserFormPage extends StatefulWidget {
  const AddUserFormPage({super.key});

  @override
  State<AddUserFormPage> createState() => _AddUserFormPageState();
}

class _AddUserFormPageState extends State<AddUserFormPage> {
  AddUserPageController controller = Get.put(AddUserPageController());

  DateTime selectedDate = DateTime.now();

  List<String> addresses = [];

  void addAddress(String address) {
    setState(() {
      addresses.add(address);
    });
  }

  void openModalBottomShet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ContainerInput(
          onSubmit: addAddress,
        );
      },
    );
  }

  Future<dynamic> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

        controller.birthDateController.text = convertedDateTime;
      });
    }
  }

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            const BackGroundCover(),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.32,
                  left: 10,
                  right: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15,
                      offset: Offset(0, 0.075))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        style: const TextStyle(color: Colors.teal),
                        controller: controller.nameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          focusColor: Colors.teal,
                          labelText: 'Nombre:',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        style: const TextStyle(color: Colors.teal),
                        controller: controller.lastNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          focusColor: Colors.teal,
                          labelText: 'Apellido:',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.birthDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.calendar_month),
                                labelText: 'Fecha de Nacimiento:'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: Card(
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: Center(
                              child: ListTile(
                            leading: const Icon(Icons.location_city),
                            title: Text(
                              "Agregar Direccion",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 124, 121, 121))),
                            ),
                            onTap: () {
                              openModalBottomShet(context);
                            },
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          controller.submitForm(context, addresses),
                      child: const Text("Crear Usuario"),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 125, top: 60),
              child: SafeArea(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/img/User-Profile.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => controller.logout(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Volver",
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackGroundCover extends StatelessWidget {
  const BackGroundCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.teal,
      alignment: Alignment.center,
    );
  }
}

class ContainerInput extends StatefulWidget {
  final Function(String) onSubmit;

  const ContainerInput({super.key, required this.onSubmit});

  @override
  State<ContainerInput> createState() => _ContainerInputState();
}

class _ContainerInputState extends State<ContainerInput> {
  TextEditingController controller = TextEditingController();

  void submitAddress() {
    widget.onSubmit(controller.text);
    Navigator.pop(context);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Puedes Agregar mas de dos Direcciones ".toUpperCase(),
            style: GoogleFonts.ubuntu(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Direccion:',
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => submitAddress(),
            child: const Text("Crear Direccion"),
          )
        ],
      ),
    );
  }
}
