import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_firebase/services/data_services.dart';

class AgregarEvento extends StatefulWidget {
  const AgregarEvento({super.key});

  @override
  State<AgregarEvento> createState() => _AgregarEventoState();
}

class _AgregarEventoState extends State<AgregarEvento> {
  final formKey = GlobalKey<FormState>();
  String? _categoriaElejida;
  DateTime? _fechaReunion;
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController lugarCtrl = TextEditingController();
  String userEmail =
      "hello@gmail.com"; //Should Be Obtained FirebaseAuth.instance.currentUser

  @override
  void dispose() {
    tituloCtrl.dispose();
    lugarCtrl.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Evento", style: TextStyle(fontSize: 15)),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.pop(context); There is no List Events Page Yet
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: tituloCtrl,
                decoration: InputDecoration(
                  labelText: 'Titulo Evento',
                  border: InputBorder.none,
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return 'Indique el nombre del Evento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lugarCtrl,
                decoration: InputDecoration(
                  labelText: 'Ubicacion Evento',
                  border: InputBorder.none,
                ),
                validator: (nombre) {
                  if (nombre!.isEmpty) {
                    return 'Indique la ubicacion del Evento';
                  }
                  return null;
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FsService().categorias(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final categorias = snapshot.data!.docs
                      .map((doc) => doc['nombreCategoria'] as String)
                      .toList();
                  return DropdownButtonFormField<String>(
                    value: _categoriaElejida,
                    hint: Text("Selecciona categoría"),
                    items: categorias.map((categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _categoriaElejida = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seleccione una categoría';
                      }
                      return null;
                    },
                  );
                },
              ),
              TextFormField(
                controller: TextEditingController(
                  text: _fechaReunion != null
                      ? "${_fechaReunion!.day}/${_fechaReunion!.month}/${_fechaReunion!.year}  ${_fechaReunion!.hour}:${_fechaReunion!.minute}"
                      : "",
                ),
                decoration: InputDecoration(labelText: "Fecha y hora"),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 7)),
                    firstDate: DateTime.now().add(
                      Duration(days: 7),
                    ), // restrict calendar
                    lastDate: DateTime(2100),
                  );
                  if (date == null) {
                    return;
                  }
                  if (!context.mounted) {
                    return;
                  }
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time == null) {
                    return;
                  }
                  final fechaFinal = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );

                  setState(() {
                    _fechaReunion = fechaFinal;
                  });
                },
                validator: (value) {
                  if (_fechaReunion == null) {
                    return 'Seleccionar FECHA Y HORA';
                  }
                  final minAllowed = DateTime.now().add(Duration(days: 7));
                  if (_fechaReunion!.isBefore(minAllowed)) {
                    return 'Agende La Reunion Para Una Semana Con Anticipacion';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: FilledButton(
                  child: Text("Ingresar Evento"),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FsService().agregarEvento(
                          tituloCtrl.text.trim(),
                          lugarCtrl.text.trim(),
                          _categoriaElejida!,
                          userEmail,
                          _fechaReunion!,
                        );
                        if (!context.mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Evento Agregado")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error de Agregado: ${e.toString()}"),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
