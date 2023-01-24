// import 'package:flutter/cupertino.dart';
// import 'package:notes/models/notes.dart';
// import 'package:notes/services/api_service.dart';
//
// class NotesProvider with ChangeNotifier {
//   List<Note> notes = [];
//
//   void addNote(Note note) {
//     notes.add(note);
//     notifyListeners();
//     ApiService.addNote(note);
//   }
//
//   void updateNote(Note note) {
//     int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
//     notes[indexOfNote] = note;
//     notifyListeners();
//     ApiService.addNote(note);
//   }
//
//   void deleteNote(Note note) {
//     int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
//     notes.removeAt(indexOfNote);
//     notifyListeners();
//     ApiService.deleteNote(note);
//   }
//
//
// }


import 'package:flutter/cupertino.dart';
import 'package:notes/services/api_service.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/services/api_service.dart';

class NotesProvider with ChangeNotifier {

  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes.where((element) => element.title!.toLowerCase().contains(searchQuery.toLowerCase()) || element.content!.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("aditya");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

}