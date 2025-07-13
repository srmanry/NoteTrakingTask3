import 'package:notetaking/feature/home/model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class LocalNoteService {
  static const String noteKey = 'notes';

  Future<List<NoteModel>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final noteList = prefs.getStringList(noteKey) ?? [];
    return noteList.map((note) {
      return NoteModel.fromJson(jsonDecode(note));
    }).toList();
  }

  Future<void> saveNotes(List<NoteModel> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final noteList = notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList(noteKey, noteList);
  }
}
