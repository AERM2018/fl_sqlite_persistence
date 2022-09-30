import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicturesScreen extends StatelessWidget {
  final String imagePath;
  final bool onlySee;
  const PicturesScreen({Key? key, required this.imagePath, required this.onlySee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pictures"),
        actions: [
         IconButton(onPressed: ()async{

            final prefers = await SharedPreferences.getInstance();
            prefers.setString("catPic", !onlySee ? imagePath : "").then((_){
              int numScreensToPop = !onlySee ? 2 : 1;
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= numScreensToPop);
            });
            
          }, icon: Icon(!onlySee ? Icons.check_rounded : Icons.delete))
        ],
      ),
      body: Image.file(File(imagePath)),
    );
  }
}