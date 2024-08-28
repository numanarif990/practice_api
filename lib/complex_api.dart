import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/users_model.dart';

class ComplexApi extends StatefulWidget {
  const ComplexApi({super.key});

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUserList() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Api"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserList(),
                  builder: (context, AsyncSnapshot<List<UsersModel>> snapShot) {
                    if (!snapShot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                   MyRow(title: "name", value: snapShot.data![index].name.toString()),
                                    MyRow(title: "username", value: snapShot.data![index].username.toString()),
                                    MyRow(title: "email", value: snapShot.data![index].email.toString()),
                                    MyRow(title: "Address", value: userList[index].address!.city.toString()),
                                    MyRow(title: "Latitude", value: snapShot.data![index].address!.geo!.lat.toString()),

                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
class MyRow extends StatelessWidget {
  String title,value;
   MyRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          // Text(userList[index].id.toString()),
           Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text(value,style: const TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}
