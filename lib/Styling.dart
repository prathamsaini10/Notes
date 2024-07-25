import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



Color hexToColor(String hexCode) {
  final buffer = StringBuffer();
  if (hexCode.length == 6 || hexCode.length == 7) {
    buffer.write('ff');
  }
  buffer.write(hexCode.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

Widget notecard(Function()? onTap,QueryDocumentSnapshot docs){
  print(docs['color']);
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(

        color:hexToColor(docs['color']),//0xffa8edea,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
           docs['title']== "" ? "Undefined" :docs['title'],

            style:  TextStyle(

                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,),

            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        //  SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              docs['notes'] == "" ? "Undefined" :  docs['notes'],
              textAlign: TextAlign.left,

              softWrap: true,
              style: const TextStyle(

                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
         // SizedBox(height: 10,),
          Text(
           docs['date'],
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    ),

  );
}