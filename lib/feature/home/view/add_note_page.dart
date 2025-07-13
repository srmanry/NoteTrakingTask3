import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetaking/common/widgets/bottom_.dart';
import 'package:notetaking/feature/home/controller/note_controller.dart';
import 'package:notetaking/feature/home/model/note_model.dart';
import 'package:notetaking/util/dimensions.dart';
import 'package:notetaking/util/styles.dart';

class NoteFormPage extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final NoteModel? note;

  NoteFormPage({required this.isEdit, this.index, this.note});
  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final controller = Get.find<NoteController>();
  String selectedColor = "0xFFFFFFFF";

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      selectedColor = widget.note!.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? "Edit Note" : "Add Note")),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.fifTeen),
        child: Column(children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: contentController, decoration: InputDecoration(hintText: "Body"),maxLines: 5,),
            SizedBox(height: Dimensions.defaultSize),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Color: ",style: textMedium,),
                DropdownButton<String>(
                  value: selectedColor,
                  items: [
                    "0xFFFFFFFF", "0xFFFFF59D", "0xFF80DEEA", "0xFFFFAB91", "0xFFA5D6A7",].
                      map((value) {return DropdownMenuItem(
                      value: value,
                      child: Container(width: 24, height: 24, color: Color(int.parse(value))),);}).toList(),
                      onChanged: (value) {setState(() {selectedColor = value!;});
                  },)
              ],),
            SizedBox(height: Dimensions.twenty),
            CustomBottom(name:widget.isEdit ? "Update" : "Save",
              onTap: () {
                final newNote = NoteModel(
                  title: titleController.text,
                  content: contentController.text, color: selectedColor, isSynced: false,
                );
                if (widget.isEdit && widget.index != null) {
                  controller.updateNote(widget.index!, newNote);
                } else {controller.addNote(newNote);}
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
