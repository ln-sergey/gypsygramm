part of 'authentification_cubit.dart';

abstract class AuthentificationState extends Equatable {
  final bool isOnline;

  const AuthentificationState(this.isOnline);

  @override
  List<Object> get props => [isOnline];

  AuthentificationState copyWith({bool isOnline});
}

class AuthentificationInitial extends AuthentificationState {
  AuthentificationInitial(bool isOnline) : super(isOnline);

  @override
  AuthentificationInitial copyWith({bool isOnline}) =>
      AuthentificationInitial(isOnline ?? this.isOnline);
}

class AuthentificationLoggedIn extends AuthentificationState {
  final String username;

  AuthentificationLoggedIn(bool isOnline, this.username) : super(isOnline);

  @override
  List<Object> get props => [isOnline, username];

  @override
  AuthentificationLoggedIn copyWith({bool isOnline}) =>
      AuthentificationLoggedIn(isOnline ?? this.isOnline, this.username);
}

class AuthentificationNotLoggedIn extends AuthentificationState {
  final String message;

  AuthentificationNotLoggedIn(bool isOnline, [this.message]) : super(isOnline);

  @override
  AuthentificationState copyWith({bool isOnline, String message}) =>
      AuthentificationNotLoggedIn(isOnline ?? this.isOnline, message);
}
