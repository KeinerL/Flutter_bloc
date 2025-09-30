import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_application_1/block/state.dart';
import 'package:flutter_application_1/estados/cargando.dart';
import 'package:flutter_application_1/estados/fallo.dart';
import 'package:flutter_application_1/estados/hecho.dart';
import 'package:flutter_application_1/estados/Inicio.dart';
import 'package:flutter_application_1/vista/User.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Fondo degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade900, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
              border: Border.all(
                color: Colors.indigo.shade200,
                width: 2,
              ),
            ),
            child: BlocConsumer<SubjectBloc, SubjectState>(
              listener: (context, state) {
                if (state is SubjectHecho) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const User()),
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is SubjectInicio) {
                  return Inicio();
                } else if (state is SubjectCargando) {
                  return Cargando();
                } else if (state is SubjectFallo) {
                  return Fallo();
                } else if (state is SubjectHecho) {
                  return Hecho();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info_outline,
                          size: 90, color: Colors.indigo),
                      const SizedBox(height: 24),
                      Text(
                        "No se ha cargado nada.\nEsto es un mensaje de aviso.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              context.read<SubjectBloc>().irInicio(),
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text("Regresar",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
