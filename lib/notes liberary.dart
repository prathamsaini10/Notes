//import 'dart:js_util';

//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Styling.dart';
import 'package:notes/notes%20data.dart';
//import 'package:notes/notes_data.dart';
import 'package:notes/update%20notes.dart';

//import 'package:notes/update_notes.dart';

class noteslib extends StatefulWidget {
  const noteslib({super.key});

  @override
  State<noteslib> createState() => _noteslibState();
}

class _noteslibState extends State<noteslib> {
  String _searchTerm = ""; // Stores the current search term
  bool isdesktop(BuildContext context)=>MediaQuery.of(context).size.width>=600;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Notes(upd: false);
                }));
              },
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                size: 30,
              )),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(

                    decoration: const InputDecoration(
                      hintText: 'Search your notes',
                      hintStyle: TextStyle(fontSize: 20),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                     // contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(Icons.search)
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value.toLowerCase(); // Make search case-insensitive
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 820, // Adjust height as needed
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Message')
                          .orderBy('date')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          final notes = snapshot.data!.docs.toList(); // Get all notes
                          final filteredNotes = notes.where((note) {
                            // Filter based on search term (case-insensitive)
                            final title = note['title'].toString().toLowerCase();
                            final content = note['notes'].toString().toLowerCase();
                            return title.contains(_searchTerm) || content.contains(_searchTerm);
                          }).toList();

                          return isdesktop(context)?GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: filteredNotes.length,
                            itemBuilder: (context, index) {
                              final note = filteredNotes[index];

                              return notecard(() {
                                final documentId = note.id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => updatenotes(note, documentId),
                                  ),
                                );
                              }, note);
                            }):GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: filteredNotes.length,
                              itemBuilder: (context, index) {
                                final note = filteredNotes[index];

                                return notecard(() {
                                  final documentId = note.id;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => updatenotes(note, documentId),
                                    ),
                                  );
                                }, note);
                              });;


                            }
                        return const Text("There are no notes");
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
