import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class SubjectBloc extends Cubit<SubjectState> {
  SubjectBloc() : super(SubjectInicio()); // Estado inicial

  void irInicio() => emit(SubjectInicio());

  // Nuevo método que valida los campos
  void validarCampos(String cod, String nombre) {
    emit(SubjectCargando());

    Future.delayed(Duration(seconds: 1), () {
      if (cod.isNotEmpty && nombre.isNotEmpty) {
        emit(SubjectHecho());
      } else {
        emit(SubjectFallo());
      }
    });
  }

  void irFallo() => emit(SubjectFallo());
  void irHecho() => emit(SubjectHecho());
}