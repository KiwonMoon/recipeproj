import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ingredient.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
bool googlelogin = false;

Future<UserCredential> signInWithGoogle() async {
  // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  googlelogin = true;
  print('google login');
  return await _auth.signInWithCredential(credential);
  // return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> googleLoginData(String userID) async {
  FirebaseFirestore.instance.collection('user').doc(userID).set({
    'email': FirebaseAuth.instance.currentUser!.email,
    'name': FirebaseAuth.instance.currentUser!.displayName,
    'uid': FirebaseAuth.instance.currentUser!.uid,
  });
}

var currentUserID = _auth.currentUser;

Future<void> signOut() async {
  // await FirebaseAuth.instance.signOut();
  // await Firebase.initializeApp();
  // try {
  //   if (googlelogin == true) {
  //     await _auth.signOut();
  //     await _googleSignIn.signOut();
  //   } else {
  //     await _auth.signOut();
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }
  // await _googleSignIn.signOut();
  await _auth.signOut();
  print('Logged OUT');
  print(currentUserID!.uid);
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            FlatButton(
              color: Colors.red.withOpacity(0.3),
              onPressed: () async {
                await signInWithGoogle();
                if (currentUserID != null) {
                  print('GOOGLE LOGIN');
                  print('<USER ID>:: ${currentUserID!.uid}');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Ingredient()));
                }
              },
              child: Text("Google Login"),
            ),
            FlatButton(
              color: Colors.grey.withOpacity(0.3),
              child: const Text('Guest'),
              onPressed: () async {
                // dynamic result = await _auth.signInAnon();
                googlelogin = false;
                await _auth.signInAnonymously();
                if (currentUserID != null) {
                  print('GUEST LOGIN');
                  print('<USER ID>:: ${currentUserID!.uid}');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Ingredient()));
                }
              },
            ),
            FlatButton(
              color: Colors.grey.withOpacity(0.3),
              child: const Text('NEXT'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ingredient()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
