import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/pages/agregar_evento.dart';
import 'package:proyecto_firebase/pages/listar_eventos.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Administrador de Eventos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(ColorsLetters().kWhiteCream),
            ),
          ),
          backgroundColor: Color(ColorsBackGround().kGreyDark),
          actions: [
            IconButton(
              color: Color(ColorsLetters().kWhiteCream),
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn.instance.signOut();
              },
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelColor: Color(ColorsLetters().kWhiteCream),
            unselectedLabelColor: Color(ColorsLetters().kWhiteCream),
            indicatorColor: Color(ColorsLetters().kWhiteCream),
            tabs: [
              Tab(text: "Lista de Eventos"),
              Tab(text: "Agregar Evento"),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(5),
          child: TabBarView(children: [ListarEventos(), AgregarEvento()]),
        ),
      ),
    );
  }
}
