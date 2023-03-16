class Employee {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;

  Employee({this.id, this.name, this.email, this.phoneNumber});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  static List<Employee> fromArray(List<dynamic> array) {
    return List.generate(
      array.length,
      (index) => Employee.fromJson(
        array[index],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
