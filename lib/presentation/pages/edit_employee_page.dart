import 'package:employee_app/api/employee_api.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditEmployeePage extends HookWidget {
  EditEmployeePage({Key? key, required this.employee}) : super(key: key);

  final Employee employee;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    TextEditingController email =
        useTextEditingController(text: "${employee.email}");
    TextEditingController name =
        useTextEditingController(text: "${employee.name}");
    TextEditingController phoneNumber =
        useTextEditingController(text: "${employee.phoneNumber}");
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Employee"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  validator: (val) => val!.isEmpty ? "Enter email" : null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (val) =>
                      val!.isEmpty ? "Enter phone number" : null,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.red,
              heroTag: "Delete",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await apiService.deleteEmployee(employee.id!);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);
                }
              },
              child: Icon(Icons.delete_forever_rounded),
            ),
            SizedBox(
              height: 8,
            ),
            FloatingActionButton(
              heroTag: "Done",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await apiService.updateEmployee(Employee(
                    id: employee.id,
                    email: email.text,
                    name: name.text,
                    phoneNumber: phoneNumber.text,
                  ));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);

                }
              },
              child: Icon(Icons.done_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
