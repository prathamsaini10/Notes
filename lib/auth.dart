import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:login_page/Utils/Utils.dart';
//import 'package:fluttertoast/flutter, [String uname]toast.dart';

signup(var emailAddress, var password,bool showspinner) async {

  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    )
        .then((value) {})
        .onError((error, stackTrace) {

    });
    showspinner=false;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {

    } else if (e.code == 'email-already-in-use') {

    }
    showspinner=true;
  }

}

signin(var email, var password,bool showspinner) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    showspinner=false;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    } else if (e.code == 'wrong-password') {
    }
    showspinner=false;
  }
}
