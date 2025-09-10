import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class fallo extends StatelessWidget {
  const fallo({
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
          "❌ Ocurrió un error",
          style: TextStyle(color: Colors.red, fontSize: 18),
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