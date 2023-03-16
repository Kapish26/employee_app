import 'dart:convert';

import 'package:employee_app/models/employee.dart';
import 'package:http/http.dart' as http;

abstract class IApiService {
  Future<void> createEmployee(Employee employee);

  Future<List<Employee>> getEmployeeList();

  Future<Employee> getEmployee(int id);

  Future<void> deleteEmployee(int id);

  Future<void> updateEmployee(Employee employee);
}

class ApiService extends IApiService {
  // Uncomment if running on emulator
  // static const String BASE_URL = "http://localhost:8000";
  static const String BASE_URL = "http://192.168.1.105:8000";

  @override
  Future<void> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/employees/'),
      body: employee.toJson(),
    );

    if (response.statusCode != 201)
      throw ([
        Exception(["Server Error"]),
        response.body
      ]);

    print(response.body);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    final response = await http.delete(
      Uri.parse('$BASE_URL/employees/$id/'),

    );

    if (response.statusCode != 204)
      throw ([
        Exception(["Server Error"]),
        response.body
      ]);

    print(response.body);
  }

  @override
  Future<Employee> getEmployee(int id) {
    // TODO: implement getEmployee
    throw UnimplementedError();
  }

  @override
  Future<List<Employee>> getEmployeeList() async {
    final response = await http.get(Uri.parse("$BASE_URL/employees/"));
    print(response.body);
    if (response.statusCode != 200)
      throw ([
        Exception(["Seerver Error"]),
        response.body
      ]);
    final data = Employee.fromArray(jsonDecode(response.body )as List<dynamic>);

    return data;
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final response = await http.put(
      Uri.parse('$BASE_URL/employees/${employee.id}/'),
      body: employee.toJson(),
    );

    if (response.statusCode != 200)
      throw ([
        Exception(["Server Error"]),
        response.body
      ]);

    print(response.body);
  }
}
