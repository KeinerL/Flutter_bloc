import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/vista/model/user_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void irInicio() => emit(UserInitial());

  void cargarUsuario(int userId) {}

  void irFallo([String mensaje = ""]) => emit(UserFailure(mensaje));
  void irHecho(UserModel user, [String? mensaje]) => emit(UserSuccess(user, mensaje));
}
