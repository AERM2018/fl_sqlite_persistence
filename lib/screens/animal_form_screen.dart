import 'package:flutter/material.dart';
import 'package:persistence_app/widgets/widgets.dart';

class AnimalFormScreen extends StatefulWidget {
  const AnimalFormScreen({Key? key}) : super(key: key);

  @override
  State<AnimalFormScreen> createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  final textControllerRace = TextEditingController();
  final textControllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final screenTitle = args['screenFor'] == "creating" ? 'New cat' : 'Edit cat';
    if(args['cat'] != null){
      textControllerName.text = args['cat'].name;
      textControllerRace.text = args['cat'].race;
    }
    return Scaffold(
      appBar: AppBar(title: Text(screenTitle)),
      body: AnimalForm(formFields: [
       {"label":"Input the race of the cat","iconData":Icons.text_format,"controller": textControllerRace,"name":"race"},
       {"label":"Input the name of the cat","iconData":Icons.android_sharp,"controller": textControllerName,
            "name": "name"
          },
      ],
      transactionType: args['screenFor'],
      id: args['cat']?.id ?? 0,),
    );
  }
}