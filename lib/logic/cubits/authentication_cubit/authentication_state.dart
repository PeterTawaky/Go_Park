part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final String? message;
  AuthenticationSuccess({required this.message});
}

final class AuthenticationError extends AuthenticationState {
  final String? errorMessage;
  AuthenticationError({required this.errorMessage});
}

final class ResetPasswordMailSentLoading extends AuthenticationState {}

final class ResetPasswordMailSentSuccess extends AuthenticationState {
  final String? message;
  ResetPasswordMailSentSuccess({required this.message});
}

final class ResetPasswordMailSentFailed extends AuthenticationState {
  final String? errorMessage;
  ResetPasswordMailSentFailed({required this.errorMessage});
}

final class LoggingOutLoading extends AuthenticationState {}
final class LoggingOutSuccess extends AuthenticationState {}

final class GoogleSignInLoading extends AuthenticationState {}
final class GoogleSignInSuccess extends AuthenticationState {}

final class GoogleSignInFailed extends AuthenticationState {
  final String? errorMessage;
  GoogleSignInFailed({ this.errorMessage});
}