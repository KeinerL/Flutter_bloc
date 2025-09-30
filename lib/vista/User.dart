import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/block/user_bloc.dart';
import 'package:flutter_application_1/block/user_state.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: Scaffold(
        // 🔹 AppBar con botón de volver automático
        appBar: AppBar(
          title: const Text("Usuario", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo.shade700,
          elevation: 4,
          centerTitle: true,
        ),

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              width: 400,
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.indigo.shade200,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images.jpeg',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Detalles del Usuario",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _idController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ID de usuario',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    final id = int.tryParse(_idController.text.trim());
                                    if (id != null) {
                                      context.read<UserCubit>().cargarUsuario(id);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('ID inválido')),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.person_search, color: Colors.white),
                                  label: const Text("Buscar usuario", style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Consultar información del usuario por ID",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          );
                        } else if (state is UserLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is UserSuccess && state.user != null) {
                          final user = state.user!;
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _infoCard(Icons.numbers, 'ID', '${user.id}'),
                              _infoCard(Icons.person, 'Nombre', user.name),
                              _infoCard(Icons.account_circle, 'Usuario', user.username),
                              _infoCard(Icons.email, 'Correo', user.email),
                              _infoCard(Icons.phone, 'Teléfono', user.phone),
                              _infoCard(Icons.web, 'Página Web', user.website),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<UserCubit>().irInicio();
                                  _idController.clear();
                                },
                                icon: const Icon(Icons.refresh, color: Colors.white),
                                label: const Text('Nueva búsqueda', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade600,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              )
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
      ),
    );
  }

  static Widget _infoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
