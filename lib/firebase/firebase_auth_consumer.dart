import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_garage_final_project/firebase/firebase_error_handler.dart';

class FirebaseAuthConsumer {
  //!========================================================================================

  static trackAuthenticationState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
  }
  //!========================================================================================

  static Future<Either<String, String>> createNewAccount({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      sendVerificationMail();
      return Right('Account created successfully, please verify your email.');
    } on FirebaseException catch (e) {
      log(e.code);
      log(e.runtimeType.toString());
      return Left(FirebaseErrorHandler.handle(e.code));
    } on Exception catch (e) {
      log(e.runtimeType.toString());
      return Left(FirebaseErrorHandler.handle(e));
    }
  }

  //!========================================================================================
  static Future<Either<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (sendVerificationMail() == true) {
        return Right('Please verify your email.');
      }
      return Right(null);
    } on FirebaseException catch (e) {
      log(e.code);
      log(e.runtimeType.toString());
      return Left(FirebaseErrorHandler.handle(e.code));
    } on Exception catch (e) {
      log(e.runtimeType.toString());
      return Left(FirebaseErrorHandler.handle(e));
    }
  }

  //!========================================================================================

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static bool? sendVerificationMail() {
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      //if email is not verified, send mail
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return true;
    }
    return null;
  }
  //!========================================================================================

  static Future<Either<String, String>> sendResetPasswordMail(
    String email,
  ) async {
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
        return Right('Please check your email to reset your password.');
      } on FirebaseException catch (e) {
        return Left(FirebaseErrorHandler.handle(e.code));
      }
    } else {
      return Left('Please enter your email address.');
    }
  }
  //!========================================================================================

  static bool isUserAuthorized() {
    //check if user logged in and email is verified
    return (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified);
  }

  //!========================================================================================

  static Future<dynamic> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //if the user get back and didn't  choose any email
      if (googleUser == null) {
        return false; //indication that authentication doesn't completed
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('Google Sign-In Error: $e');
      rethrow;
    }
  }

  //!========================================================================================
  static signOutFromGoogle() async {
    await GoogleSignIn().disconnect();
  }
}
