import 'package:flutter/material.dart';
import 'package:notice/helpers/custom_functions.dart';
import 'package:notice/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'add_notes_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().queryAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes++'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            context.read<HomeProvider>().deleteAll();
          }, icon: const Icon(Icons.delete_forever))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (builder) => AddNotesView())),
        child: const Icon(Icons.add),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, data, child){
          return data.notesList.isNotEmpty ? ListView.builder(
              itemCount: data.notesList.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.notesList[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text(data.notesList[index]['notes'], maxLines: 3,overflow: TextOverflow.ellipsis,),
                            ],
                          ),

                          IconButton(onPressed: (){
                            data.deleteData(id: data.notesList[index]['id'], context: context);
                          }, icon: const  Icon(Icons.delete)),

                        ],
                      ),

                      Container(
                          alignment: Alignment.bottomRight,
                          child: Text(data.notesList[index]['timestamp'], style: const TextStyle(fontSize: 8, color: Colors.grey), textAlign: TextAlign.right,)),
                      const Divider(),

                    ],
                  ),
                );
              }): const Center(child: Text('No Data Found'),);
        },

      ),
    );
  }
}
