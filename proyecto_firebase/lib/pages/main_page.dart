import 'package:flutter/material.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/pages/agregar_evento.dart';
import 'package:proyecto_firebase/pages/listar_eventos.dart';
import 'package:proyecto_firebase/pages/placeholder.dart';

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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          backgroundColor: Color(ColorsBackGround().kGreyDark),
          actions: [
            IconButton(
              color: Color(ColorsLetters().kWhiteCream),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //Navigator.pop(context); There is no List Events Page Yet
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
              Tab(text: "[ Lista de Eventos ]"),
              Tab(text: "[ Agregar Evento ]"),
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
