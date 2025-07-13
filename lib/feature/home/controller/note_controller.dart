import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as connectivity;
import 'package:get/get.dart';
import 'package:notetaking/feature/home/model/note_model.dart';


import 'note_api_service.dart';
import 'note_service.dart';

class NoteController extends GetxController {
  final notes = <NoteModel>[].obs;

  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final _localService = LocalNoteService();
  final _apiService = NoteApiService();

  @override
  void onInit() {
    super.onInit();
    _startConnectivityListener();
    loadNotes();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _startConnectivityListener() {
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> connectivityResults,) {
      final connectivity.ConnectivityResult result = connectivityResults.first;
      if (result != ConnectivityResult.none) {
        retrySync();
      }
    });
  }

  void loadNotes() async {
    final loadedNotes = await _localService.getNotes();
    notes.assignAll(loadedNotes);
    retrySync();
  }

  void addNote(NoteModel note) async {
    final success = await _apiService.syncNote(note);
    note.isSynced = success;
    notes.add(note);
    _localService.saveNotes(notes);
  }

  void updateNote(int index, NoteModel note) async {
    final success = await _apiService.syncNote(note);
    note.isSynced = success;
    notes[index] = note;
    notes.refresh();
    _localService.saveNotes(notes);
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    _localService.saveNotes(notes);
  }

  void retrySync() async {
    for (int i = 0; i < notes.length; i++) {
      if (!notes[i].isSynced) {
        final success = await _apiService.syncNote(notes[i]);
        print("retry.....sync.${success}");
        if (success) {
          notes[i].isSynced = true;
        }
      }
    }
    _localService.saveNotes(notes);
    notes.refresh();
  }
}
