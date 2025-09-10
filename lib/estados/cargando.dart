import 'package:flutter/material.dart';

class cargando extends StatelessWidget {
  const cargando({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 200),
        CircularProgressIndicator()
      ],
    );
  }
}