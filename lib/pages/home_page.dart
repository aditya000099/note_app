// import 'package:flutter/cupertino.dart';
// import  'package:flutter/material.dart';
// import 'package:notes/models/notes.dart';
// import 'package:notes/pages/add_new_note.dart';
// import 'package:notes/providers/notes_provider.dart';
// import 'package:provider/provider.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     NotesProvider notesProvider = Provider.of<NotesProvider>(context);
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(24,24,24, 1.0),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(18,18,18, 1.0),
//         title: const Text("Notes App"),
//       ),
//       body: SafeArea(
//         child: (notesProvider.notes.isNotEmpty)? GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2
//           ),
//           itemCount: notesProvider.notes.length,
//           itemBuilder: (context,index){
//             Note currentNote = notesProvider.notes[index];
//
//               return Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, CupertinoPageRoute(builder: (context) => AddNewNotePage(isUpdate: true, note: currentNote,)
//                     ));
//                   },
//                   onLongPress: () {
//                     notesProvider.deleteNote(currentNote);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(10),
//
//                     decoration: BoxDecoration(
//                         color: const Color.fromRGBO(18,18,18, 0.5),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Colors.white,
//                             width: 1
//                       )
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(currentNote.title!, style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.white, fontSize: 22),maxLines: 1, overflow: TextOverflow.ellipsis,),
//                         const SizedBox(height: 8,),
//                         Text(currentNote.content!, style: const TextStyle(fontSize: 20 , color: Colors.white70),maxLines: 5, overflow: TextOverflow.ellipsis,)
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//           },
//         ) : const Center(child: Text("No Notes yet..", style: TextStyle(color: Colors.white),),),
//       ),
//       floatingActionButton: FloatingActionButton(
//         hoverElevation: 15,
//         hoverColor: Colors.white10,
//         onPressed: (){
//           Navigator.push(context, CupertinoPageRoute(
//               fullscreenDialog: true,
//               builder: (context) =>  const AddNewNotePage(isUpdate: false,)));
//         },
//         backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/pages/add_new_note.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(24,24,24, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18,18,18, 1.0),
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false) ? SafeArea(
        child: (notesProvider.notes.isNotEmpty) ? ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Search",
                  hintStyle: TextStyle( color: Colors.white),
                ),
              ),
            ),

            (notesProvider.getFilteredNotes(searchQuery).isNotEmpty) ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
              ),
              itemCount: notesProvider.getFilteredNotes(searchQuery).length,
              itemBuilder: (context, index) {

                Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];

                return GestureDetector(
                  onTap: () {
                    // Update
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AddNewNotePage(isUpdate: true, note: currentNote,)
                      ),
                    );
                  },
                  onLongPress: () {
                    // Delete
                    notesProvider.deleteNote(currentNote);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(18,18,18, 0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey,
                          width: 2
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentNote.title!, style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.white, fontSize: 22),maxLines: 1, overflow: TextOverflow.ellipsis,),                        const SizedBox(height: 7,),
                        Text(currentNote.content!, style: TextStyle( fontSize: 18, color: Colors.grey[700] ), maxLines: 5, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                );

              },
            ) : const Padding(
              padding: EdgeInsets.all(20),
              child: Text("No notes found!", textAlign: TextAlign.center,),
            ),
          ],
        ) : const Center(
          child: Text("No notes yet" , style: TextStyle(color: Colors.white),),
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddNewNotePage(isUpdate: false,)
            ),
          );
        },
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
        child: const Icon(Icons.add),
      ),
    );
  }
}