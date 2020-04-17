// TODO:  imports

import 'dart:async';
import 'Employee.dart';

// TODO: List of Employers

class EmployeeBloc {
  // Sink is used to add into the pipe
  // Stream is used to get data from the pipe
  // By pipe I mean data flowing

  List<Employee> _employeeList = [
    Employee(1, 'Employee One', 1000.0),
    Employee(2, 'Employee Two', 2000.0),
    Employee(3, 'Employee Three', 3000.0),
    Employee(4, 'Employee Four', 4000.0),
    Employee(5, 'Employee Five', 5000.0),
  ];

  // TODO: Stream Controllers

  final _employeeListStreamController = StreamController<List<Employee>>();

  // for increment and decrement

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();

  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // TODO: Stream Sink getter
  // getter

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  // TODO: Constructor - add data; listen to changes

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);

    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  // TODO: Core Functions

  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id  - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;

    _employeeList[employee.id  - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

// TODO: dispose

  void dispose() {
    _employeeSalaryIncrementStreamController.close();

    _employeeSalaryDecrementStreamController.close();

    _employeeListStreamController.close();
  }
}
