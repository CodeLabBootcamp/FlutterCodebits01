import 'package:basics_of_basics/models/post.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Post post;

  const DetailsScreen({Key key, @required this.post}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Center(
        child: Text(widget.post.body),
      ),
    );
  }
}
