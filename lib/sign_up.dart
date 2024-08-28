import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
void login(String email, String password) async{
  try{
 Response response = await post(
   Uri.parse("https://reqres.in/api/login"),
       body: {
         'email': email,
         'password': password
       }
 );
 if(response.statusCode == 200){
   var data = jsonDecode(response.body.toString());
   print(data);
   print("succeeded");
 }else{
   print("failed");
 }
  }catch(e){
    print(e.toString());
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey
              ),
              decoration: InputDecoration(
                hintText: "Email",
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey
                  )
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,
                        color: Colors.white
                    )
                )
              ),

            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey
              ),
              decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey
                      )
                  ),
                  enabledBorder:const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3,
                          color: Colors.white
                      )
                  )
              ),

            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
             login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange
                ),
                child: const Center(child: Text("Login", style: TextStyle(fontSize: 28, color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
