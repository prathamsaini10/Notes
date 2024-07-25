import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class updatenotes extends StatefulWidget {
  updatenotes(this.docs,this.doc,{super.key});
  QueryDocumentSnapshot docs;
String doc;

  @override
  State<updatenotes> createState() => _updatenotesState();
}

class _updatenotesState extends State<updatenotes> {
  late TextEditingController note1;

  late TextEditingController title1;

  String? Date;
  currentdate() {
    DateTime now = DateTime.now();
    String formatteddate = DateFormat('dd MMM,yyyy').format(now);
    Date = formatteddate;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentdate();
    note1 = TextEditingController(text: widget.docs['notes']);
    title1 = TextEditingController(text: widget.docs['title']);
  }



  void updatedata() async {
    // print(widget.docs['title']==title1.text);
    if (widget.docs['title'] == title1.text &&
        widget.docs['notes'] == note1.text) {
      showDialog(
          context: context,
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  title: const Center(
                      child: Text(
                    'Error',
                    style: TextStyle(fontSize: 30),
                  )),
                  content: const Column(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 130,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                          child: Text(
                        'Update Some data Before Updating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ),
              ],
            );
          });
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('Message')
            .doc(widget.doc)
            .update({
          'title': title1.text,
           'date': Date!,
          'notes': note1.text
        }).whenComplete(() {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlertDialog(
                      title: const Center(
                          child: Text(
                        'Data Saved',
                        style: TextStyle(fontSize: 30),
                      )),
                      content: const Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 130,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Text(
                            'Your Data has been Updated Successfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'))
                      ],
                    ),
                  ],
                );
              });
        });
      } catch (e) {
        print('Error $e');
print(widget.doc);
        showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    title: const Center(
                        child: Text(
                      'Error',
                      style: TextStyle(fontSize: 30),
                    )),
                    content: const Column(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 130,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Text(
                          'Try Again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                ],
              );
            });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.18,
                      ),
                    const Text(
                      'Notes',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.06,
                    ),
                    TextButton(
                      onPressed: () {
                        updatedata();
                      },
                      child: const Icon(Icons.save_alt,color: Colors.white,),
                    ),
                    TextButton(
                      onPressed: () async{
                        Navigator.of(context).pop(); // Close the dialog
                        // Call your delete function here
                        // Perform the delete operation

                        try {
                          CollectionReference collection = FirebaseFirestore.instance.collection(
                              'Message');

                          DocumentReference docref = collection.doc(widget.doc);

                          await docref.delete();
                        } catch (e) {
                          print("Error deleting document: $e");
                        }

                      },
                      style: const ButtonStyle(
                          alignment: AlignmentDirectional(0, 0)),
                      child: const Icon(Icons.delete,color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[900], height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  maxLines: 1,
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
                child: TextField(
                  controller: note1,
                  keyboardType: TextInputType.multiline,
                  //minLines:1,
                  maxLines: null,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Note',
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
