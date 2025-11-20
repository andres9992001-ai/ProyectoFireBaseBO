import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_firebase/services/auth_google_services.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(MdiIcons.google),
          label: const Text('Iniciar sesión con Google'),
          onPressed: () async {
            // implmentar el inicio de sesion con google con services.
            final userC = await AuthGoogleServices().signInWithGoogle();
            if (userC != null) {
              print("Login exitoso: ${userC.email}");
            }
          },
        ),
      ),
    );
  }
}
