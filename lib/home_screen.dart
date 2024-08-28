import 'dart:convert';

import 'package:api_practice/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostData() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        for (Map i in data) {
          postList.add(PostsModel.fromJson(i));
        }
        return postList;
      } else {
        // Handle non-200 responses here
        return postList;
      }
    } catch (e) {
      // Handle exceptions by logging or displaying them
      print(e.toString());
      return postList; // Return empty list on exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style:
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text(postList[index].title.toString()),
                                Text("Body",
                                    style:
                                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(postList[index].body.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
