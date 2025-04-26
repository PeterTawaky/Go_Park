import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_garage_final_project/core/utils/firebase_constants.dart';

class FirebaseErrorHandler {
  static String handle(dynamic error) {
    switch (error) {
      case FirebaseResponses.channelError:
        log(FirebaseResponses.channelError);
        return FirebaseHandledResponses.channelError;
      case FirebaseResponses.invalidEmail:
        log(FirebaseHandledResponses.invalidEmail);
        return FirebaseHandledResponses.invalidEmail;
      case FirebaseResponses.emailAlreadyInUse:
        log(FirebaseHandledResponses.emailAlreadyInUse);
        return FirebaseHandledResponses.emailAlreadyInUse;
      case FirebaseResponses.weakPassword:
        log(FirebaseHandledResponses.weakPassword);
        return FirebaseHandledResponses.weakPassword;
      case FirebaseResponses.userNotFound:
        log(FirebaseHandledResponses.userNotFound);
        return FirebaseHandledResponses.userNotFound;
      case FirebaseResponses.wrongPassword:
        log(FirebaseHandledResponses.wrongPassword);
        return FirebaseHandledResponses.wrongPassword;
      case FirebaseResponses.operationNotAllowed:
        log(FirebaseHandledResponses.operationNotAllowed);
        return FirebaseHandledResponses.operationNotAllowed;
      case FirebaseResponses.tooManyRequests:
        log(FirebaseHandledResponses.tooManyRequests);
        return FirebaseHandledResponses.tooManyRequests;
      case FirebaseResponses.userDisabled:
        log(FirebaseHandledResponses.userDisabled);
        return FirebaseHandledResponses.userDisabled;
      case FirebaseResponses.invalidCredential:
        log(FirebaseHandledResponses.invalidCredential);
        return FirebaseHandledResponses.invalidCredential;
      default:
        log(FirebaseHandledResponses.defaultError);
        return FirebaseHandledResponses.defaultError;
    }
  }
}
