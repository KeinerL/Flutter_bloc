import 'package:equatable/equatable.dart';

abstract class SubjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubjectInicio extends SubjectState {}

class SubjectCargando extends SubjectState {}

class SubjectFallo extends SubjectState {
  final String mensaje;
  SubjectFallo([this.mensaje = ""]);
  @override
  List<Object?> get props => [mensaje];
}

class SubjectHecho extends SubjectState {
  final String? resultado;
  SubjectHecho([this.resultado]);
  @override
  List<Object?> get props => [resultado];
}