import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/email_verified_dashboard.dart';
import 'package:firebase_auth_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const EmailVerifiedDashboard();
        } else {
          return const Home();
        }
      }),
    );
  }

  signInWithGoogle() async {
    //trigger authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"],
    ).signIn();

    //obtain auth details from request

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create new credential

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

// once signed in , return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// Sign Out
  signOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
