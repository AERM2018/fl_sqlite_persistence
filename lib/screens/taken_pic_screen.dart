import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:async';

import 'package:persistence_app/screens/screens.dart';
class TakenPicScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakenPicScreen({Key? key, required this.camera}) : super(key: key);

  @override
  State<TakenPicScreen> createState() => _TakenPicScreenState();
}

class _TakenPicScreenState extends State<TakenPicScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera,ResolutionPreset.max);
   _initializeControllerFuture = _controller.initialize(); 
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take a picture"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async{
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if(!mounted) return;
            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PicturesScreen(imagePath: image.path,onlySee: false,)));
          } catch (e) {
            print(e);
          }
        },
      ),
    ); 
  }
}