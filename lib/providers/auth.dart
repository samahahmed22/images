import 'dart:async';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus { unAuthenticated, authentecating, authenticated }

class Auth with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  AuthStatus _authStatus = AuthStatus.unAuthenticated;
  User _user;

  Auth() {
    _firebaseAuth = FirebaseAuth.instance;
    _user = _firebaseAuth.currentUser;
      if (_user == null) {
        _authStatus = AuthStatus.unAuthenticated;
      } else {
        _authStatus = AuthStatus.authenticated;
      }
      notifyListeners();
  
  }

  AuthStatus get authStatus => _authStatus;
  User get user => _user;

  Future<void> loginWithFacebook() async {
    final FacebookLoginResult result = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (result.status) {
      case FacebookLoginStatus.Cancel:
        break;
      case FacebookLoginStatus.Error:
        print(result.error);
        break;
      case FacebookLoginStatus.Success:
        try {
          _authStatus = AuthStatus.authentecating;
          notifyListeners();
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          await _firebaseAuth.signInWithCredential(credential);
          _authStatus = AuthStatus.authenticated;
          notifyListeners();
        } catch (e) {
          print(e);
          _authStatus = AuthStatus.unAuthenticated;
          notifyListeners();
        }
        break;
    }
    notifyListeners();
  }

  Future<void> loginInWithGoogle() async {
    GoogleSignInAccount userAccount = await _googleSignIn.signIn();
    if (userAccount == null) {
      return;
    } else {
      try {
        _authStatus = AuthStatus.authentecating;
        notifyListeners();
        GoogleSignInAuthentication googleAuth =
            await userAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        await _firebaseAuth.signInWithCredential(credential);
        _authStatus = AuthStatus.authenticated;
        notifyListeners();
      } catch (e) {
        print(e);
        _authStatus = AuthStatus.unAuthenticated;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<void> logout() async {
    if (_user.providerData[0].providerId == 'facebook.com') {
      await _facebookLogin.logOut();
    } else if (_user.providerData[0].providerId == 'google.com') {
      await _googleSignIn.disconnect();
    }
    await _firebaseAuth.signOut();
    _user = null;
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }
}
