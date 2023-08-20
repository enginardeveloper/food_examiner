import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String content;
  const ErrorPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(content)),
    );
  }


}