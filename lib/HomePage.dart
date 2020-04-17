import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Employee App'),
        ),
        body: Container(
            child: StreamBuilder(
          stream: _employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          '${snapshot.data[index].id}.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${snapshot.data[index].name}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '₦${snapshot.data[index].salary}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              color: Color(0xff276749),
                            ),
                            onPressed: () => _employeeBloc
                                .employeeSalaryIncrement
                                .add(snapshot.data[index])),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(
                              Icons.thumb_down,
                              color: Color(0xffE53E3E),
                            ),
                            onPressed: () {
                              _employeeBloc.employeeSalaryDecrement
                                  .add(snapshot.data[index]);
                            }),
                      )
                    ],
                  ),
                );
              },
            );
          },
        )));
  }
}
