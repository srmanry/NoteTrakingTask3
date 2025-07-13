
import 'package:http/http.dart' as http;
import 'package:notetaking/feature/home/model/note_model.dart';
import 'dart:convert';


class NoteApiService {
  Future<bool> syncNote(NoteModel note) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': note.title,
          'body': note.content,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}