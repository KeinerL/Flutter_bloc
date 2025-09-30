import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/vista/model/user_model.dart';
import 'user_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void irInicio() => emit(UserInitial());

  Future<void> cargarUsuario(int userId) async {
    emit(UserLoading());
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data);
        emit(UserSuccess(user));
      } else {
        emit(UserFailure('Usuario no encontrado (código: ${response.statusCode})'));
      }
    } catch (e) {
      emit(UserFailure('Error de conexión'));
    }
  }

  void irFallo([String mensaje = ""]) => emit(UserFailure(mensaje));
  void irHecho(UserModel user, [String? mensaje]) => emit(UserSuccess(user, mensaje));
}
