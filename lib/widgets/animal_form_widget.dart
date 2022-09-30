// import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:persistence_app/helpers/db_helper.dart';
import 'package:persistence_app/models/cat_model.dart';
import 'package:persistence_app/screens/pictures_screen.dart';
import 'package:persistence_app/screens/taken_pic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/src/widgets/framework.dart';

class AnimalForm extends StatefulWidget {
  final List<Map<String,dynamic>> formFields;
  final bool includePicBtn;
  final String? picPath;
  final String transactionType;
  final int? id;
  final Future Function() startCamera;
  const AnimalForm({Key? key, required this.formFields, required this.transactionType, this.id, required this.startCamera, required this.includePicBtn, this.picPath }) : super(key: key);

  
  @override
  State<AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    picPath = widget.picPath!;
  }
  String? picPath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ...widget.formFields.map((field) => TextField(
            enabled: field['isEnabled'],
            controller: field['controller'],decoration: InputDecoration(label: Text(field['label']), icon: Icon(field['iconData'])
            ),
          ))
         ,
          if(widget.includePicBtn)  Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              child: Text(picPath == "" ? "Take pic" : "See pic"), onPressed: () {
                if(picPath == ""){
                  widget.startCamera().then((camera) {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TakenPicScreen(camera: camera)))
                          .then((_) async => await setCatPic());
                    });
                }else{
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PicturesScreen(imagePath: picPath!,onlySee: picPath != "",)))
                                      .then((_) async => await setCatPic());
                }
                
              },
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
              onPressed: (){
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
            }, child: const Text("Save Cat")),
          ),
             
        ],
      ),
    );
  }

  setCatPic() async{
    final prefers = await SharedPreferences.getInstance();
    picPath= prefers.getString("catPic");
    final filed = widget.formFields.firstWhere((element) => element['name'] == "picPath");
    filed["controller"].text = picPath;
      setState(() {});
    }
}