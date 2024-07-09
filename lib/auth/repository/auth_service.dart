import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authServiceProvider = Provider((ref)=>
    AuthService(googleSignIn: GoogleSignIn(),
    auth: FirebaseAuth.instance));
class AuthService {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  AuthService({
    required this.googleSignIn,
    required this.auth,
  });

  signInWithGoogle() async{
    final user = await googleSignIn.signIn();
    final googleAuth=  await user!.authentication;
  final crendential =   GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


   await auth.signInWithCredential(crendential);
  }




}