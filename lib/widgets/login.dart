import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_api/widgets/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

class LoginPage extends StatelessWidget {
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter email"),
            keyboardType: TextInputType.emailAddress, controller: emailEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter password",),
              obscureText: true, controller: passwordEditingController,),
            ElevatedButton(onPressed: (){
              loginUser(emailEditingController.text, passwordEditingController.text)
                  .then((response) async {
                 if (response.statusCode == 200){
                   if (jsonDecode(response.body)["token"] != null) {
                     var token = jsonDecode(response.body)["token"];
                     SnackBar snackbar = SnackBar(content: Text("Successfully logged in"));
                     ScaffoldMessenger.of(context).showSnackBar(snackbar);

                     // Homework = Change this part of code using then
                     //Change to  then  to remove the error message on navigator push
                     SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.setString("token", token);

                     // THis should always be the last thing on the function
                     // Once this is called, as if the page no longer exist (context is passed to second page)

                     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

                   }
                   
                 }
                 else {
                   SnackBar snackbar = SnackBar(content: Text("Something is wrong"));
                   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                 }
              });

            }, child: Text("Login")),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
            }, child: Text("No account? Register now!"))
          ],
        ),
      ),
    );
  }
  Future<http.Response> loginUser(String email, String password) {
    return http.post(
      Uri.parse('https://employee-rest-api-vs0n.onrender.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password':password
      }),
    );
  }


}
