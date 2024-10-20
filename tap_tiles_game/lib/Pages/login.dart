import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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