import 'package:employee_app/api/employee_api.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/presentation/pages/create_employee_page.dart';
import 'package:employee_app/presentation/pages/edit_employee_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Employee Detail App"),
      ),
      body: FutureBuilder<List<Employee>>(
        future: apiService.getEmployeeList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0)
              return Center(child: Text("No Employee in database"));
            final employees = snapshot.data as List<Employee>;
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      print(employee.id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditEmployeePage(employee: employee),
                        ),
                      );
                    },
                    title: Text("${employee.name}"),
                    subtitle: Text("${employee.phoneNumber}"),
                    trailing: Text("${employee.email}"),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "Add",
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateEmployeePage()));
        },
        label: const Text("Add employee"),
      ),
    );
  }
}
