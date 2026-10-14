import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // Returns the Google ID token, or null if cancelled or failed.
  Future<String?> getIdToken() async {
    // supportsAuthenticate() returns false on web — Android is fine.
    if (!GoogleSignIn.instance.supportsAuthenticate()) return null;

    try {
      // Sign out first to force account picker on every attempt.
      await GoogleSignIn.instance.signOut();

      final account = await GoogleSignIn.instance.authenticate();

      // authentication is now a synchronous getter — no await.
      return account.authentication.idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      return null;
    } catch (_) {
      return null;
    }
  }
}
