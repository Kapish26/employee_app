import 'package:employee_app/api/employee_api.dart';
import 'package:employee_app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'home_page.dart';

class CreateEmployeePage extends HookWidget {
  CreateEmployeePage({Key? key}) : super(key: key);

  ApiService apiService = ApiService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController email = useTextEditingController();
    TextEditingController name = useTextEditingController();
    TextEditingController phoneNumber = useTextEditingController();
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
          title: const Text("Add Employee"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
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
                      validator: (val) => val!.isEmpty ? "Enter email" : null,
                      controller: email,
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
                      validator: (val) =>
                          val!.isEmpty ? "Enter phone number" : null,
                      keyboardType: TextInputType.phone,
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
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await apiService.createEmployee(Employee(
                      name: name.text,
                      email: email.text,
                      phoneNumber: phoneNumber.text,
                    ));

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomePage()),
                        (route) => false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Add Employee",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
