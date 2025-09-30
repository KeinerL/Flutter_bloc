import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_application_1/vista/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final TextEditingController codController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  @override
  void dispose() {
    codController.dispose();
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Fondo con gradiente
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 400,
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Registro de Usuario",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo Cod
                TextField(
                  controller: codController,
                  decoration: InputDecoration(
                    labelText: 'Código',
                    prefixIcon: const Icon(Icons.confirmation_number),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Nombre
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Botón Guardar
                ElevatedButton.icon(
                  onPressed: () async {
                    final cod = codController.text.trim();
                    final nombre = nombreController.text.trim();

                    final api = ApiService();
                    final response = await api.createPost(cod, nombre);
                    context.read<SubjectBloc>().validarCampos(cod, nombre);

                    if (response.statusCode == 201 &&
                        cod.isNotEmpty &&
                        nombre.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Usuario creado: (${response.statusCode})"),
                        ),
                      );
                    } else if (cod.isEmpty || nombre.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Los campos no pueden estar vacíos"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: (${response.statusCode})"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text("Guardar",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
