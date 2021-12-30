import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/taskmodel.dart';
import 'package:todoapp/style/style.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

List<Todo> todos = [];

class _AddTaskState extends State<AddTask> {
  
  List category = [
    "High",
    "Medium",
    "Low",
  ];
  bool showDropdown = false;

  TextEditingController _dateController = TextEditingController();
  DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  DateTime taskDate = DateTime.now();
  DatePicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: taskDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    setState(() {
      taskDate = date!;
    });
    _dateController.text = _dateFormatter.format(date!);
  }

  TextEditingController _todoController = TextEditingController();

  TextEditingController _priorityController = TextEditingController();

  void clearText() {
    _dateController.clear();
    _todoController.clear();
    _priorityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.k_white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColor.k_white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyTaskScreen()));
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: KColor.k_bg,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: KTextStyle.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: KTextFields(
                controller: _todoController,
                obsecuretext: false,
                keyboardtype: TextInputType.text,
                decoration: InputDecoration(
                    label: Text(
                      'Todo',
                      style: TextStyle(color: KColor.k_brderOutline),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    )),
              )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  obscureText: false,
                  style: TextStyle(fontSize: 15),
                  onTap: DatePicker,
                  decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle:
                          TextStyle(fontSize: 15, color: KColor.k_brderOutline),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (showDropdown) {
                              showDropdown = false;
                            } else {
                              showDropdown = true;
                            }
                          });
                        },
                        child: TextFormField(
                          controller: _priorityController,
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: "Priority",
                              labelStyle: TextStyle(
                                  fontSize: 15, color: KColor.k_brderOutline),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              suffixIcon: Icon(
                                showDropdown
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                size: 18,
                              )),
                        ),
                      ),
                      showDropdown
                          ? Container(
                              width: MediaQuery.of(context).size.width - 50,
                              margin: const EdgeInsets.only(top: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      List.generate(category.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _priorityController.text =
                                              category[index];
                                          showDropdown = false;
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "${category[index]}",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                            )
                          : Container(),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    todos.add(Todo(
                        todo: _todoController.text,
                        date: DateFormat('MMM dd, yyyy')
                            .parse(_dateController.text),
                        priority: _priorityController.text,
                        checked: false));
                    clearText();
                    Navigator.pop(context);
                  });
                },
                child: Button(
                  button: 'Add',
                  color: KColor.k_bg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
