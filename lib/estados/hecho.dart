import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class hecho extends StatelessWidget {
  const hecho({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Text(
          "✅ Proceso realizado con exito",
          style: TextStyle(color: const Color.fromARGB(255, 73, 244, 54), fontSize: 18),
          ),
        SizedBox(
          height: 150,
        ),
        ElevatedButton(
          onPressed: () => context.read<SubjectBloc>().irInicio(),
          child: Text('Regresar'),
        ),
      ],
    );
  }
}