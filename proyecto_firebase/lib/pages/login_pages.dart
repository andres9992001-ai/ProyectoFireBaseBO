import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_firebase/constants.dart';
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
      appBar: AppBar(title: const Text('App Administrador de eventos')),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            color: Color(ColorsLetters().kWhiteCream),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(ColorsLetters().kWhiteCream),
              width: 2,
            ),
          ),
          child: ElevatedButton.icon(
            icon: Icon(MdiIcons.google),

            label: const Text(
              'Iniciar sesión con Google',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0, // sin sombra
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
              padding: EdgeInsets.zero,
            ),

            onPressed: () async {
              // implmentar el inicio de sesion con google con services.
              final userC = await AuthGoogleServices().signInWithGoogle();
              if (userC != null) {
                print("Login exitoso: ${userC.email}");
              }
            },
          ),
        ),
      ),
    );
  }
}
