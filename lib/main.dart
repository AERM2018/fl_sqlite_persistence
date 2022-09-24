import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:persistence_app/screens/screens.dart';
import 'package:persistence_app/screens/taken_pic_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({Key? key, required this.camera}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'takenPicture',
      routes: {
        'home':(context)=> const HomeScreen(),
        'animalForm':(context)=> const AnimalFormScreen(),
        'takenPicture':(context)=> TakenPicScreen(camera: camera,)
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}