import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'mainPage.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: () async{
            final _googleSignIn = GoogleSignIn();
            final googleAccount = await _googleSignIn.signIn();

            if (googleAccount != null) {
              final googleAuth = await googleAccount.authentication;

              if (googleAuth.accessToken != null && googleAuth.idToken != null) {
                try {
                  await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
                    idToken: googleAuth.idToken,
                    accessToken: googleAuth.accessToken,
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home())
                  );
                } on FirebaseAuthException catch (e) {
                      print('error $e');
                    } catch (e) {
                      print('error $e');
                    }
                  } else
                    print('error');
                } else
                  print('error');
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Text(
                      "구글로그인",
                      style: TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
