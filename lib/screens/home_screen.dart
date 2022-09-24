import 'package:flutter/material.dart';
import 'package:persistence_app/helpers/db_helper.dart';
import 'package:persistence_app/widgets/cat_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
  var cats = DbHelper.instance.getCats();
    return Scaffold(appBar: AppBar(
      title: const Text('Cats'),
      elevation: 0,
    ),
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical:0),
      child: SizedBox(
        child:CatList(cats: cats, deleteFunc: deleteCatHandler, updateFunc: refreshData,)
      )
    ),
    floatingActionButton: FloatingActionButton( backgroundColor: Colors.indigo, child: const Icon(Icons.add), onPressed: () async{
      var refreshList = await Navigator.pushNamed(context, "animalForm",arguments: {"screenFor":"creating"});
      if(refreshList == true) refreshData();
    },),
    );
  }

  deleteCatHandler(int? id) async{
    DbHelper.instance.deleteCat(id!);
    setState((){});
  }

  refreshData(){
    setState(() {});
  }
}