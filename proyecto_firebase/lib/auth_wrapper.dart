import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_firebase/pages/agregar_evento.dart';
import 'package:proyecto_firebase/pages/login_pages.dart';
import 'package:proyecto_firebase/pages/main_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          print("USER LOGEADO: ${snapshot.data?.email}");
          return PaginaPrincipal();
        }

        return LoginPages();
      },
    );
  }
}
