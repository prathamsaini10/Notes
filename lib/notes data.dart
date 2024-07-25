import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notes/Styling.dart';
//import 'package:notes/main.dart';
import 'package:notes/notes%20data.dart';
import 'firebase_options.dart';

class Notes extends StatefulWidget {
  Notes({this.message,this.docId,this.time,this.title,required this.upd});
  bool upd ;
  String? title;
  String? message;
  String? time;
  String? docId;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  String randomColorGenerate() {
    final random = Random();
    final red = 150 + random.nextInt(106);
    final green = 150 + random.nextInt(106);
    final blue = 150 + random.nextInt(106);
    final color = Color.fromARGB(255, red, green, blue);
    return '#' +
        red.toRadixString(16).padLeft(2, '0') +
        green.toRadixString(16).padLeft(2, '0') +
        blue.toRadixString(16).padLeft(2, '0');
  }
  String? Date;
  currentdate() {
    DateTime now = DateTime.now();
    String formatteddate = DateFormat('dd MMM,yyyy').format(now);
    Date = formatteddate;
  }

  Future<void> savedata() async {
    CollectionReference user = FirebaseFirestore.instance.collection("Message");

    try {
      if (title1.text == "" && note1.text == "") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Error",
                  style: TextStyle(fontSize: 30),
                ),
                content: Container(
                  constraints: BoxConstraints(
                    maxHeight: 300

                  ),
                  child: const Column(
                    children: [
                      Icon(
                        CupertinoIcons.xmark,
                        color: Colors.red,
                        size: 120,
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Enter Some data before saving',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay'))
                ],
              );
            });
      } else {
      await user.add(
          {
          'title': title1.text,
          'notes': note1.text,
            'date': Date!,
            'color':randomColorGenerate()
        }).whenComplete((){
          Navigator.pop(context);
          showDialog(context: context, builder:(context){
            return AlertDialog(

              title: const Text(
                "Data Saved",
                style: TextStyle(fontSize: 30),
              ),
              content: Container(
                constraints: BoxConstraints(
                  maxHeight: 300
                ),
                child: const Column(
                  children: [
                    Icon(
                      CupertinoIcons.checkmark_circle,
                      color: Colors.green,
                      size: 120,
                    ),SizedBox(height: 30,),
                    Text(
                      'Your data is saved sucessfully',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'))
              ],
            );
          } );
      });
      }
    } catch (e) {
      print('Error $e');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Error",
                style: TextStyle(fontSize: 30),
              ),
              content: Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: const Column(
                  children: [
                    Icon(
                      CupertinoIcons.xmark,
                      color: Colors.red,
                      size: 120,
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'Try Again',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    currentdate();
  }

  var note1 = TextEditingController();
  var title1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 55),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                          textStyle: MaterialStatePropertyAll(
                              TextStyle(fontSize: 20))),
                      child: const Icon(CupertinoIcons.arrow_left,color: Colors.white,),
                    ),
                    const Text(
                      'Notes',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 30),
                    ),
                    // SizedBox(width: 172,),
                    TextButton(
                      onPressed: () { savedata();},
                      style: const ButtonStyle(
                          textStyle: MaterialStatePropertyAll(
                              TextStyle(fontSize: 20))),
                      child: const Icon(Icons.save_alt,color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[900], height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  maxLines: 1,
                  // maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  controller: title1,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Stack(children: [
                  TextField(
                    controller: note1,
                    keyboardType: TextInputType.multiline,
                    //minLines:1,
                    maxLines: 22,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 720),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        // Divider(color: Colors.grey[900]),
                        Text(
                          'Editted $Date',
                          style: const TextStyle(fontSize: 14,fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
