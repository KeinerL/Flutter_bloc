import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/vista/model/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String mensaje;
  UserFailure([this.mensaje = ""]);
  @override
  List<Object?> get props => [mensaje];
}

class UserSuccess extends UserState {
  final UserModel? user;
  final String? mensaje;
  UserSuccess([this.user, this.mensaje]);
  @override
  List<Object?> get props => [user, mensaje];
}
