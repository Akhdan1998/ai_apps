import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/LogReg_services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String? name;
String? userEmail;
String? uid;
String? imageUrl;

Future<User?> signInWithGoogle() async {
  User? user;
  GoogleSignInAccount? account = await GoogleSignIn().signIn();
  if (account != null) {
    GoogleSignInAuthentication auth = await account.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    user = userCredential.user!;
    if (user != null) {
      name = user.displayName;
      userEmail = user.email;
      uid = user.uid;
      imageUrl = user.photoURL;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      LogRegGoogle(
        name.toString(),
        userEmail.toString(),
        uid.toString(),
        imageUrl.toString(),
      );
      return user;
    }
    return user;
  }
  return user;
}
