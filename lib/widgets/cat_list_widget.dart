import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistence_app/helpers/db_helper.dart';
import 'package:persistence_app/models/cat_model.dart';

class CatList extends StatefulWidget {
  final Future<List<Cat>> cats;
  final Function deleteFunc;
  final Function updateFunc;
  const CatList({Key? key, required this.cats, required this.deleteFunc,
      required this.updateFunc}) : super(key: key);

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: FutureBuilder(future:widget.cats,
          builder: (context,AsyncSnapshot<List<Cat>> catsList) {
            if(catsList.hasData){
              if(catsList.data!.isEmpty){
                return const Center(child: Text("There're no cats"));
              }else{
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context,i) => GestureDetector(
                    onDoubleTap: ()async{
                      var refreshList = await Navigator.pushNamed(context, "animalForm",arguments: {"screenFor":"editing","cat": catsList.data![i]
                              });
                      if(refreshList== true){
                        widget.updateFunc();
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.only(top: 15),
                      
                      child: ListTile(
                        title: Text(catsList.data![i].name),
                        subtitle: Text(catsList.data![i].race),
                        trailing: IconButton(icon: const Icon(Icons.delete),color: Colors.red,onPressed: ()=>widget.deleteFunc(catsList.data![i].id),)),
                    ),
                  ), 
                    itemCount: catsList.data!.length);
              }
            }else{
              return const Center(child: Text("Loading..."));
            }
  }));
  }
}