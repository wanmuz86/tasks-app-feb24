import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Enter email"),
          keyboardType: TextInputType.emailAddress,),
          TextField(decoration: InputDecoration(hintText: "Enter password",),
            obscureText: true,),
          ElevatedButton(onPressed: (){}, child: Text("Login")),
          TextButton(onPressed: (){
            
          }, child: Text("No account? Register now!"))
        ],
      ),
    );
  }
}
