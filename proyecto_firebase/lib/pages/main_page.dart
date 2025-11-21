import 'package:flutter/material.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/pages/agregar_evento.dart';
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
          title: Text("Administrador de Eventos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          backgroundColor: Color(kCeleste),
          actions: [
            IconButton(
              color: Color(kRojo),
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //Navigator.pop(context); There is no List Events Page Yet
              },
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelColor: Color(kRojo),
            unselectedLabelColor: Color(kAzulMarino),
            indicatorColor: Color(kDorado),
            tabs: [
              Tab(icon: Icon(Icons.event), text: "Lista de Eventos"),
              Tab(icon: Icon(Icons.edit_calendar), text: "Agregar Evento"),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(5),
          child: TabBarView(children: [Placeholder1(), AgregarEvento()]),
        ),
      ),
    );
  }
}
