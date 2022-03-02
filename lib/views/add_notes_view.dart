import 'package:flutter/material.dart';
import 'package:notice/providers/home_provider.dart';
import 'package:provider/provider.dart';

class AddNotesView extends StatelessWidget {
   AddNotesView({Key? key}) : super(key: key);
   final titleTextController = TextEditingController();
   final notesTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes++'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             TextField (
              maxLines: 1,
              autofocus: true,
              controller: titleTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Title',
                  hintText: 'Enter Your Notes Title'

              ),
    ),
            const SizedBox(height: 10,),
             TextField (
                maxLength: 1000,
                controller: notesTextController,
                maxLines: 5,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Notes',
                    hintText: 'Enter Your Notes'

                ),
    ),
            const SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              if(notesTextController.text.isNotEmpty){
                context.read<HomeProvider>().insertData(notes: notesTextController.text, title: titleTextController.text);
                notesTextController.clear();
                titleTextController.clear();
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter notes first.')));
              }
            }, child:const Text('Save')),

    ],
        ),
      ),
    );
  }
}
