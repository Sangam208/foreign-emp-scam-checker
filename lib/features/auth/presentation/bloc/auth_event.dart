part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {}

final class AuthCurrentUser extends AuthEvent {}

final class AuthSignOut extends AuthEvent {}
