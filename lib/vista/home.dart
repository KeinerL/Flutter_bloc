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

class home extends StatelessWidget {
  const home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          constraints: BoxConstraints(
            maxWidth: 500,
            maxHeight: 600,
          ),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
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
                Future.delayed(Duration(seconds: 2), () {
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
                return cargando();
              } else if (state is SubjectFallo) {
                return fallo();
              } else if (state is SubjectHecho) {
                return hecho();
              } else {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Icon(Icons.info_outline, size: 80, color: Colors.indigo),
                      SizedBox(height: 24),
                      Text(
                        "No se ha cargado nada, esto es un mensaje de aviso",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => context.read<SubjectBloc>().irInicio(),
                        child: Text("Regresar"),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
