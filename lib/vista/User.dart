import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/block/user_bloc.dart';
import 'package:flutter_application_1/block/user_state.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..cargarUsuario(1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del Usuario'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 4,
        ),
        body: Center(
          child: Container(
            width: 400,
            constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Colors.indigo.shade200,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images.jpeg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.mensaje}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UserInitial) {
                        return const Center(
                            child: Text("Inicia la búsqueda del usuario..."));
                      } else if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserSuccess && state.user != null) {
                        final user = state.user!;
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _infoRow('ID:', '${user.id}'),
                            _infoRow('Nombre:', user.name),
                            _infoRow('Usuario:', user.username),
                            _infoRow('Correo:', user.email),
                            _infoRow('Teléfono:', user.phone),
                            _infoRow('Página WEB:', user.website),
                          ],
                        );
                      } else if (state is UserFailure) {
                        return Center(
                          child: Text(
                            "Error: ${state.mensaje}",
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return const Center(child: Text("Estado desconocido"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
