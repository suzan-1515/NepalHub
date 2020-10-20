import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:samachar_hub/core/constants/api_keys.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_auth/data/services/remote_service.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

class AuthRemoteService with RemoteService {
  static const String REGISTER = '/register';
  static const String LOGIN = '/login';
  static const String PROFILE = '/user-profiles';

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final HttpManager httpManager;

  AuthRemoteService(this._firebaseAuth, this._googleSignIn, this._facebookAuth,
      this.httpManager);

  @override
  Future<User> fetchCurrentUser() {
    return Future.value(_firebaseAuth.currentUser);
  }

  @override
  Future loginWithFacebook() async {
    final LoginResult result = await _facebookAuth.login();

    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);

    return userCredential;
  }

  @override
  Future loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    return userCredential;
  }

  @override
  Future loginWithTwitter() async {
    // Create a TwitterLogin instance
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: ApiKeys.TWITTER_CONSUMER_KEY,
      consumerSecret: ApiKeys.TWITTER_CONSUMER_SECRET_KEY,
    );

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token, secret: twitterSession.secret);

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(twitterAuthCredential);

    return userCredential;
  }

  @override
  Future signup({@required String uid}) {
    final Map<String, String> body = {
      'uid': uid,
    };
    var call = httpManager.post(path: REGISTER, body: body);
    return call;
  }

  @override
  Future loginWithEmail({String identifier, String password}) {
    final Map<String, String> body = {
      'identifier': identifier,
      'password': password,
    };
    var call = httpManager.post(path: LOGIN, body: body);

    return call;
  }

  @override
  Future logout({@required UserEntity userEntity}) async {
    await _firebaseAuth.signOut();
  }

  @override
  Future fetchUserProfile({@required String token}) {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var call = httpManager.get(path: PROFILE, headers: headers);

    return call;
  }

  @override
  Future login({String uid}) {
    final Map<String, String> body = {
      'uid': uid,
    };
    var call = httpManager.post(path: LOGIN, body: body);

    return call;
  }
}
