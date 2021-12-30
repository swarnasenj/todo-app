import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/model/taskmodel.dart';
import 'package:todoapp/style/k_color.dart';
import 'addtask_screen.dart';

class MyTaskScreen extends StatefulWidget {
  @override
  _MyTaskScreenState createState() => _MyTaskScreenState();
}
//SharedPreferences? sharedPreferences;

class _MyTaskScreenState extends State<MyTaskScreen> {
  SharedPreferences? sharedPreferences;
  DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Tasks',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'of',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(todos.length.toString()),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          todos.removeAt(index);
                          count--;
                        });
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 25),
                        child: Icon(Icons.delete, color: Colors.white),
                        color: Colors.red,
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            todos[index].todo,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: todos[index].checked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          subtitle: Text(
                            '${dateFormat.format(todos[index].date)}* ${todos[index].priority}',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                decoration: todos[index].checked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            activeColor: KColor.k_bg,
                            value: todos[index].checked,
                            onChanged: (bool? value) {
                              setState(() {
                                todos[index].checked = value!;
                                if (todos[index].checked) {
                                  count++;
                                } else {
                                  count--;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KColor.k_bg,
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
