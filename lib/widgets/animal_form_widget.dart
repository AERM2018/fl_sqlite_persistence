// import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:persistence_app/helpers/db_helper.dart';
import 'package:persistence_app/models/cat_model.dart';
// import 'package:flutter/src/widgets/framework.dart';

class AnimalForm extends StatefulWidget {
  final List<Map<String,dynamic>> formFields;
  final String transactionType;
  final int? id;
  const AnimalForm({Key? key, required this.formFields, required this.transactionType, this.id }) : super(key: key);

  @override
  State<AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ...widget.formFields.map((field) => TextField(
            controller: field['controller'],decoration: InputDecoration(label: Text(field['label']), icon: Icon(field['iconData'])
            ),
          ))
         ,
          ElevatedButton(onPressed: (){
            final Map<String,String> newAnimal = {};
            widget.formFields.forEach((field){
              newAnimal[field['name']] = field['controller'].text;
              });
            if(widget.transactionType == 'creating'){
              DbHelper.instance.addCat(Cat.fromMap(newAnimal));
            }else{
              DbHelper.instance.updateCat(Cat.fromMap(newAnimal),widget.id!);
            }
            const refreshList = true;
            Navigator.pop(context,refreshList);
          }, child: const Text("Save Cat"))
        ],
      ),
    );
  }
}