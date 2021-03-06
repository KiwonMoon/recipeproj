import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ingredient.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
bool googlelogin = false;

Future<UserCredential> signInWithGoogle() async {
  // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
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
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Image.asset('images/recipe.png',
                      scale: 2.5,),
                    ),
                    const SizedBox(height: 40.0),
                    Text('MY RECIPE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),),
                    SizedBox(height: 60,),
                  ],
                ),
                FlatButton(
                  color: Colors.red.withOpacity(0.3),
                  onPressed: () async {
                    await signInWithGoogle();
                    if (currentUserID != null) {
                      print('GOOGLE LOGIN');
                      print('<USER ID>:: ${currentUserID!.uid}');
                      saveUser();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Ingredient()));
                    }
                  },
                  child: Text("Google Login",style: TextStyle(fontSize: 18),),
                  minWidth: 140,
                  height: 40,
                ),
                FlatButton(
                  color: Colors.grey.withOpacity(0.3),
                  child: const Text('Guest',style: TextStyle(fontSize: 18),),
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
                  minWidth: 140,
                  height: 40,
                ),
                // FlatButton(
                //   color: Colors.grey.withOpacity(0.3),
                //   child: const Text('NEXT'),
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => Ingredient()));
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<dynamic> saveUser() async {
    var currentUser = _auth.currentUser!;

    CollectionReference users = FirebaseFirestore.instance.collection('bookmark');
    users.doc(currentUser.uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        print("ok google sign in");
        return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Ingredient()),
        );
      } else {
        print('Document does not exist on the database');
        users.doc(currentUser.uid).set({
          'img': [],
          'recipeTitle': [],
        }).catchError((error) => print("Failed to add user: $error"))
            .then((value) {
          print("ok google sign in");
          return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ingredient()),
          );
        });
      }
    });
  }

}


