import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_application_1/block/state.dart';
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
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: 50),
          Text("Cod:", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          TextField(
            controller: codController,
            decoration: InputDecoration(
              labelText: 'Escribe algo',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 50),
          Text("Nombre:", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          TextField(
            controller: nombreController,
            decoration: InputDecoration(
              labelText: 'Escribe algo',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 80),
          ElevatedButton(
            onPressed: () async {
              final cod = codController.text.trim();
              final nombre = nombreController.text.trim();

              // Llamamos al servicio
              final api = ApiService();
              final response = await api.createPost(cod, nombre);
              context.read<SubjectBloc>().validarCampos(cod, nombre);

              if (response.statusCode == 201 && cod.isNotEmpty && nombre.isNotEmpty) {
                // JSONPlaceholder devuelve 201 cuando se crea
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Usuario creado: (${response.statusCode})")),
                );
              } else if (cod.isEmpty || nombre.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("los campos no pueden estar vacíos")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: (${response.statusCode})")),
                );
              }
            },
            child: Text('Guardar'),
          ),

        ],
      ),
    );
  }
}
