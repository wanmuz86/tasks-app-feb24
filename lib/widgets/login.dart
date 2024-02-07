import 'package:flutter/material.dart';
import 'package:tasks_api/widgets/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter email"),
            keyboardType: TextInputType.emailAddress,),
            TextField(decoration: InputDecoration(hintText: "Enter password",),
              obscureText: true,),
            ElevatedButton(onPressed: (){}, child: Text("Login")),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
            }, child: Text("No account? Register now!"))
          ],
        ),
      ),
    );
  }


}
