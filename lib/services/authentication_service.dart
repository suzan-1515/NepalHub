import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:samachar_hub/data/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  AuthenticationService(
      this._firebaseAuth, this._googleSignIn, this._facebookAuth);

  Future<UserCredential> loginWithEmail({
    @required String email,
    @required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail(
      {@required String email, @required String password}) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInAnonymously() {
    return (_firebaseAuth.signInAnonymously());
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return (_firebaseAuth.signInWithCredential(credential));
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await _facebookAuth.login();

    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    return _firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final TwitterLogin twitterLogin =
        new TwitterLogin(consumerKey: '', consumerSecret: '');

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token, secret: twitterSession.secret);

    // Once signed in, return the UserCredential
    return _firebaseAuth.signInWithCredential(twitterAuthCredential);
  }

  Future<void> saveUserProfile({@required UserModel user}) async {
    return _usersCollectionReference.doc(user.uId).set(user.toJson());
  }

  Future<DocumentSnapshot> getUserProfile({@required String uid}) {
    return _usersCollectionReference.doc(uid).get();
  }

  Future<User> currentUser() {
    return Future.value(_firebaseAuth.currentUser);
  }

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }
}
