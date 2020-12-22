import 'dart:convert';
import 'dart:async';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  User _user;

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
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          await _firebaseAuth.signInWithCredential(credential);
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  Future<void> loginInWithGoogle() async {
    GoogleSignInAccount user = await _googleSignIn.signIn();
    if (user == null) {
      return;
    } else {
      GoogleSignInAuthentication googleAuth = await user.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _firebaseAuth.signInWithCredential(credential);
      
    }
  }

  Future<void> logout() async {
    _user = _firebaseAuth.currentUser;
    if (_user.providerData[0].providerId ==
        'facebook.com') {
      await _facebookLogin.logOut();
    }
    if (_user.providerData[0].providerId == 'google.com') {
      await _googleSignIn.disconnect();
    }
    await _firebaseAuth.signOut();
  }
}
