import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
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
            onPressed: () {
              final cod = codController.text.trim();
              final nombre = nombreController.text.trim();
              context.read<SubjectBloc>().validarCampos(cod, nombre);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
