import 'dart:io';

import 'package:flutter/material.dart';

class PicturesScreen extends StatelessWidget {
  final String imagePath;
  const PicturesScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pictures"),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}