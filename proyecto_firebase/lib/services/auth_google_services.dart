// ...existing code...
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGoogleServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    // Asegura que siempre se muestre la cuenta de Google
    try {
      await GoogleSignIn.instance.initialize();
      // Usar constructor nombrado y pasar serverClientId en Android si lo requiere

      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final usercred = await _auth.signInWithCredential(credential);
      return usercred.user;
    } catch (e) {
      print("ERROR GOOGLE SIGNIN: $e");
      return null;
    }
  }
}
// ...existing code...