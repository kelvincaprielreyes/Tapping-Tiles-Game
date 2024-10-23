import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Login In Page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.green[900]
      ),
      backgroundColor: Colors.green[300],
      body:  Column(
        children: [
          ElevatedButton(
            onPressed: () async
            {
              try{
                final credential = await GoogleSignIn();
              }
              on FirebaseAuthException catch (e)
              {
                print(e.code);
              }
              Navigator.pushNamedAndRemoveUntil(context, '/game', (Route<dynamic> route) => false);

            },
            child: const Text("Login In With Google"))
        ],
      ),
    );
  }
}

// Google Sign in Function
Future<UserCredential> GoogleSignIn() async
{
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}

// Sign Out Button Function
Future<void> SignOutButton(context) async
{
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacementNamed(context, '/login');
}

// Get High Score of the User
Future<int> getHighScore(String userID) async
  {
    // Get User Information
    final firestore = FirebaseFirestore.instance;
    final data = await firestore.collection('users').doc(userID).get();
    int result = 0;

    // If the document exists:
    if (data.exists)
    {
      result = data["High Score"] as int;
    }
    // Else add the user with a default High Score of 0
    else
    {
      await firestore.collection("users").doc(userID).set({'High Score': 0});
    }

    return result;
  }


// Store new high score
Future<void> storeNewHighScore(int newHighScore) async
{
  // Get User Information
  final userID = FirebaseAuth.instance.currentUser?.uid;
  if (userID == null)
  {
    // Print for now
    print("Not Logged In?!");
  }
  else
  {
    try{
      // Attempt to update the score in firebase
        final firestore = FirebaseFirestore.instance;
        final document = firestore.collection('users').doc(userID);
        await document.update({"High Score": newHighScore});

    }
    catch(e)
    {
      print(e);
    }
  }
}