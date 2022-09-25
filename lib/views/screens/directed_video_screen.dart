import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectedVideoScreen extends StatefulWidget {
  final data;
  DirectedVideoScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DirectedVideoScreen> createState() => _DirectedVideoScreenState();
}

class _DirectedVideoScreenState extends State<DirectedVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Center(
              child: Text('ASED'),
            );
          }),
    );
  }
}
