import 'dart:convert';

import 'package:basics_of_basics/models/post.dart';
import 'package:basics_of_basics/screens/details_screen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "Original title";

  Future<List<Post>> postsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      // to understand more about the future and future builder read this article
      // https://medium.com/@thedude61636/flutter-changing-ui-asynchronously-c48f31ae4705
      body: FutureBuilder(
        future: postsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = snapshot.data[index];
                return Container(
                  height: 100,
                  child: InkWell(
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              post.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Expanded(
                              child: Text(post.body),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return DetailsScreen(
                          post: post,
                        );
                      }));
                    },
                  ),
                );
              },
            );

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      postsFuture = _getPosts();
    });
  }

  Future<List<Post>> _getPosts() async {
    print("getting posts");
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/posts");

    List<Post> posts = [];
    for (var post in json.decode(response.body)) {
      posts.add(Post.fromJson(post));
    }
    return posts;
  }
}
