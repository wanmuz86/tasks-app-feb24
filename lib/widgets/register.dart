import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  var nameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var nricEditingController = TextEditingController();
  var phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Enter name"),
              controller: nameEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter email"),
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter password",
              ),
              controller: passwordEditingController,
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter NRIC"),
              controller: nricEditingController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Enter phone number"),
              controller: phoneEditingController,
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(onPressed: () {
              // In Dart ()=> lambda expression (one liner function)
              // (){} => Function for more than one line
              registerUser(nameEditingController.text, emailEditingController.text,
              passwordEditingController.text, nricEditingController.text, phoneEditingController.text)
                  .then((response){
                    // Response is the HTTP Response from server,
                // Check the statusCode
                    if (response.statusCode == 200){
// response.body => transform into an object/ map
                    // Check if the token exist, if it exists -> succesful registration
                      if (jsonDecode(response.body)["token"] != null){
                        SnackBar snackbar = SnackBar(content: Text("Successfully registered"));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        Navigator.pop(context);
                      }

                    }
                    else {
                      SnackBar snackbar = SnackBar(content: Text("Something is wrong"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.pop(context);
                    }
              });


            }, child: Text("Register")),
          ],
        ),
      ),
    );
  }
  Future<http.Response> registerUser(String name, String email, String password,
      String nric, String phone) {
    return http.post(
      Uri.parse('https://employee-rest-api-vs0n.onrender.com/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email':email,
        'password':password,
        'phone_num':phone,
        'nric':nric
      }),
    );
  }
}
