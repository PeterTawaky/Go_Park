class FirebaseResponses {
  FirebaseResponses._();
  static const String channelError =
      'channel-error'; //happens when there is no internet and if text field is empty
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String invalidEmail = 'invalid-email';
  static const String weakPassword = 'weak-password';
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String tooManyRequests = 'too-many-requests';
  static const String userDisabled = 'user-disabled';
  static const String invalidCredential = 'invalid-credential';
}

class FirebaseHandledResponses {
  FirebaseHandledResponses._();

  static const String channelError = 'channel error happens';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String emailAlreadyInUse = 'This email is already in use.';
  static const String weakPassword =
      'Your password is too weak. Try a stronger one.';
  static const String userNotFound = 'No account found with this email.';
  static const String wrongPassword = 'Incorrect password. Please try again.';
  static const String operationNotAllowed = 'This action is not allowed.';
  static const String tooManyRequests =
      'Too many attempts. Please wait and try again later.';
  static const String userDisabled = 'This account has been disabled.';
  static const String defaultError = 'An unexpected error occurred.';
  static const String invalidCredential = 'your account or password is wrong';
}
