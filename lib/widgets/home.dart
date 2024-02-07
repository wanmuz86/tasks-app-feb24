import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Task> _tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void loadData(){
    fetchTasks().then((value) => setState((){
      _tasks = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List"),),
      body: ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index){
            return
                Card(
                  child: ListTile(
                    title: Text(_tasks[index].name),
                    subtitle: Text("${_tasks[index].place} - ${_tasks[index].date}"),
                    trailing: Icon(Icons.chevron_right),
                  ),
                );
          }),
    );
  }

  Future<List<Task>> fetchTasks() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final response = await http
        .get(Uri.parse('https://employee-rest-api-vs0n.onrender.com/api/tasks'),
          headers: <String, String>{
        'Authorization': 'Bearer ${token!}',
      },
    );

    if (response.statusCode == 200) {

      return Task.tasksFromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {

      throw Exception('Failed to load album');
    }
  }
}
