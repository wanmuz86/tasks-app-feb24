import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class AddPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var placeEditingController = TextEditingController();
  var descEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new item"),),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Enter Name"), controller: nameEditingController,),
          TextField(decoration: InputDecoration(hintText: "Enter Description"), controller: descEditingController,),
          TextField(decoration: InputDecoration(hintText: "Enter Place"), controller: placeEditingController,),
          ElevatedButton(onPressed: (){
            createTask(nameEditingController.text, descEditingController.text, placeEditingController.text).then((response){
              if (response.statusCode == 200){
                print("Successful");
              }
              else {
                print("Something is wrong");
              }
            });

          }, child: Text("Add new Task"))
        ],
      ),
    );
  }
  Future<http.Response> createTask(String name, String description, String place) async {
    final SharedPreferences prefs  = await SharedPreferences.getInstance();
    // Get the current date code
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    var token = prefs.getString("token"); // get -> dynamic , getString,getInt,getDouble
    return http.post(
      Uri.parse('https://employee-rest-api-vs0n.onrender.com/api/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'place':place,
        'description':description,
        'completed':false,
        'user_id':2,
        'date':date
      }),
    );
  }
}
