import 'package:flutter/material.dart';
import 'package:persistence_app/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home':(context)=> const HomeScreen(),
        'animalForm':(context)=> const AnimalFormScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.red
        )
      ),
    );
  }
}