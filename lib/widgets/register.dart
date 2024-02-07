import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter name")),
            TextField(decoration: InputDecoration(hintText: "Enter email"),
              keyboardType: TextInputType.emailAddress,),
            TextField(decoration: InputDecoration(hintText: "Enter password",),
              obscureText: true,),
            TextField(decoration: InputDecoration(hintText: "Enter NRIC"),
             ),
            TextField(decoration: InputDecoration(hintText: "Enter phone number"),
              keyboardType: TextInputType.phone,),
            ElevatedButton(onPressed: (){}, child: Text("Register")),

          ],
        ),
      ),
    );
  }
}
