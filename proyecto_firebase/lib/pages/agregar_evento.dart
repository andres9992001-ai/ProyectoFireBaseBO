import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_firebase/constants.dart';
//import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
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
      FirebaseAuth.instance.currentUser?.email ?? "test@gmail.com";

  @override
  void dispose() {
    tituloCtrl.dispose();
    lugarCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(ColorsLetters().kWhiteCream),
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    controller: tituloCtrl,
                    style: TextStyle(
                      color: Color(ColorsLetters().kWhiteCream),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Titulo Evento',
                      labelStyle: TextStyle(
                        color: Color(ColorsLetters().kWhiteCream),
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (nombre) {
                      if (nombre!.isEmpty) {
                        return 'Indique el nombre del Evento';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(ColorsLetters().kWhiteCream),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: lugarCtrl,
                    style: TextStyle(
                      color: Color(ColorsLetters().kWhiteCream),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Ubicacion Evento',
                      labelStyle: TextStyle(
                        color: Color(ColorsLetters().kWhiteCream),
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (nombre) {
                      if (nombre!.isEmpty) {
                        return 'Indique la ubicacion del Evento';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(ColorsLetters().kWhiteCream),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FsService().categorias(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final categorias = snapshot.data!.docs;
                      return DropdownButtonFormField<String>(
                        value: _categoriaElejida,
                        hint: Text(
                          "Selecciona categoría",
                          style: TextStyle(
                            color: Color(ColorsLetters().kWhiteCream),
                            fontSize: 20,
                          ),
                        ),
                        items: categorias.map((doc) {
                          String nombreCategoria = doc['nombreCategoria'];
                          String imagen = doc['imagen'];
                          return DropdownMenuItem<String>(
                            value: nombreCategoria,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/$imagen.jpg',
                                  width: 24,
                                  height: 20,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.info);
                                  },
                                ),
                                SizedBox(width: 5),
                                Text(
                                  nombreCategoria,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(ColorsLetters().kWhiteCream),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: Color(ColorsLetters().kWhiteCream),
                      fontSize: 20,
                    ),
                    controller: TextEditingController(
                      text: _fechaReunion != null
                          ? "${_fechaReunion!.day}/${_fechaReunion!.month}/${_fechaReunion!.year}  ${_fechaReunion!.hour}:${_fechaReunion!.minute}"
                          : "",
                    ),
                    decoration: InputDecoration(
                      labelText: "Fecha y hora",
                      labelStyle: TextStyle(
                        color: Color(ColorsLetters().kWhiteCream),
                        fontSize: 20,
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(Duration(days: 7)),
                        firstDate: DateTime.now().add(
                          Duration(days: 7),
                        ), // restringe la fecha de 7 DIAS para adelante
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
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(ColorsLetters().kWhiteCream),
                    border: Border.all(
                      color: Color(
                        ColorsLetters().kWhiteCream,
                      ), // Color del borde
                      width: 2,
                    ),
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero, // No altera el tamaño
                      side: BorderSide.none, // Sin borde
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "[S] Ingresar Evento",
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          // INSERTA LOS DATOS OBTENEDOS al COMBOBOX EVENTOS
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
                          formKey.currentState!.reset();
                          tituloCtrl.clear();
                          lugarCtrl.clear();
                          setState(() {
                            _categoriaElejida = null;
                            _fechaReunion = null;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error de Agregado: ${e.toString()}",
                              ),
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
      ),
    );
  }
}
