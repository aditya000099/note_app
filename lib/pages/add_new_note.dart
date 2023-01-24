// import "package:flutter/material.dart";
// import 'package:notes/models/notes.dart';
// import 'package:notes/providers/notes_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
//
// class AddNewNotePage extends StatefulWidget{
//   final bool isUpdate;
//   final Note? note;
//   const AddNewNotePage({ Key? key , required this.isUpdate, this.note}) : super(key : key);
//   @override
//   _AddNewNotePageState createState() => _AddNewNotePageState();
// }
//
// class _AddNewNotePageState extends State<AddNewNotePage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController contentController = TextEditingController();
//
//   void addNewNote () {
//     Note newNote = Note(
//       id: const Uuid().v1(),
//       userid: "aditya",
//       title: titleController.text,
//       content: contentController.text,
//       dateadded: DateTime.now()
//     );
//     Provider.of<NotesProvider>(context , listen: false).addNote(newNote);
//     Navigator.pop(context);
//   }
//
//   void updateNote() {
//     widget.note!.title = titleController.text;
//     widget.note!.content = contentController.text;
//     Provider.of<NotesProvider>(context , listen: false).updateNote(widget.note!);
//     Navigator.pop(context);
//   }
//   @override
//   void initState() {
//     super.initState();
//     if(widget.isUpdate){
//       titleController.text = widget.note!.title!;
//       contentController.text = widget.note!.content!;
//     }
//
//   }
//
//   FocusNode noteFocus = FocusNode();
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(24,24,24, 1.0),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(18,18,18, 1.0),
//         actions: [
//           IconButton(onPressed: (){
//             if(widget.isUpdate){
//               updateNote();
//             }
//             else{
//               addNewNote();
//             }
//
//           },
//               icon: const Icon(Icons.check))
//         ],
//       ),
//       body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 10
//         ),
//         child: Column(
//           children:  [
//             TextField(
//               controller: titleController,
//               onSubmitted: (val){
//                 if(val != ""){
//                   noteFocus.requestFocus();
//                 }
//               },
//               autofocus: (widget.isUpdate == true) ?false : true,
//               style: const TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                   color: Colors.white
//               ),
//               decoration: const InputDecoration(
//                 hintText: "Title",
//                   hintStyle: TextStyle( color: Colors.white),
//                   border: InputBorder.none
//
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: contentController,
//                 focusNode: noteFocus,
//                 maxLines: null,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.white
//                 ),
//                 decoration: const InputDecoration(
//                     hintStyle: TextStyle( color: Colors.white),
//                     hintText: "Add Note",
//                   border: InputBorder.none
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({ Key? key, required this.isUpdate, this.note }) : super(key: key);

  @override
  _AddNewNotePageState createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userid: "aditya",
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now()
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if(widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24,24,24, 1.0),

      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(18,18,18, 1.0),
        actions: [

          IconButton(
            onPressed: () {
              if(widget.isUpdate) {
                updateNote();
              }
              else {
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10
          ),
          child: Column(
            children: [

              TextField(
                controller: titleController,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (val) {
                  if(val != "") {
                    noteFocus.requestFocus();
                  }
                },
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
                decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none
                ),
              ),

              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                  decoration: const InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}