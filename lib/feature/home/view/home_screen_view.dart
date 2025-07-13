import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetaking/feature/home/controller/note_controller.dart';
import 'package:notetaking/theme/light_theme.dart';

import 'add_note_page.dart';

class HomeScreenView extends StatelessWidget {
  final controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightTheme.primaryColor,
        title: Text( "Note Tracking",style: TextStyle(color: Theme.of(context).cardColor), ),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => ListView.builder(
            itemCount: controller.notes.length,
            itemBuilder: (_, index) {
              final note = controller.notes[index];
              return Card( color: Color(int.parse(note.color)),
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(  icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteNote(index),),
                  onTap:() => Get.to(() =>  NoteFormPage(isEdit: true, index: index, note: note), ),
                ),);
            },),
        ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightTheme.primaryColor,
        onPressed: () => Get.to(() => NoteFormPage(isEdit: false)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
