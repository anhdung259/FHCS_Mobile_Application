import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}

Future<String> signInWithGoogle() async {
  GoogleSignInAccount googleSignInAccount;
  try {
    googleSignInAccount = await googleSignIn.signIn();
  } on PlatformException catch (err) {
    print('Have error: $err');
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  print('accessToken Google: ' + credential.accessToken);

  return credential.accessToken;
  //return null;
}

// Future<void> initializeFirebase() async {
//   FirebaseApp firebaseApp = await Firebase.initializeApp();
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   var firebaseMessageToken = await messaging.getToken();
//   print("FirebaseMessaging token: $firebaseMessageToken");
//   User user = FirebaseAuth.instance.currentUser;

//   if (user != null) {}

//   return firebaseApp;
// }
