import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
//import 'package:http/http.dart';
import 'package:t06_apaflex_am/List_Tabla/student/formulario.dart';
import 'package:t06_apaflex_am/List_Tabla/student/mostrar_tabla.dart';
import 'package:t06_apaflex_am/model/student.dart';
import 'package:t06_apaflex_am/services/StudentApi.dart';
import 'package:http/http.dart' as http;
import 'package:t06_apaflex_am/List_Tabla/student/studentInactivos.dart';

void main() {
  runApp(StudentInactive());
}

class StudentInactive extends StatefulWidget {
  StudentInactive({Key? key}) : super(key: key);
  //const MaestroStudent({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StudentInactiveState createState() => _StudentInactiveState();
}

class _StudentInactiveState extends State<StudentInactive> {
  final url =
      Uri.parse("http://192.168.88.8:8085/oraclecloud/v1/students/deactivate");
  late List<Student> students = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    getStudents();
  }

  Future<void> getStudents() async {
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(utf8.decode(res.bodyBytes));
        print('Respuesta del servidor: $jsonList');

        List<Student> studentList = [];

        for (var jsonItem in jsonList) {
          if (jsonItem != null && jsonItem is Map<String, dynamic>) {
            try {
              studentList.add(Student.fromJson(jsonItem));
            } catch (e) {
              print('Error al decodificar un estudiante: $e');
            }
          }
        }

        setState(() {
          students = studentList;
        });
      } else {
        print('Error en la solicitud: ${res.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD0606),
        title: Text(
          'ESTUDIANTES INACTIVOS',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_box,
                color: Colors.white,
                size:
                    35), // Tamaño personalizado (ajústalo según tus preferencias)
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaestroStudent(),
                ),
              );
            },
          ),
        ],
      ),
      body: students.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentCard(
                  student: students[index],
                  onEditPressed: () {
                    (students[index]);
                  },
                  context: context, // Pasa el contexto aquí
                );
              },
            ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onEditPressed;
  final BuildContext context;

  StudentCard({
    required this.student,
    required this.onEditPressed,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    String documentInfo =
        '${student.document_type_id}:${student.number_document}';

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 255, 17, 0), width: 2.0),
      ),
      child: _buildCardContents(documentInfo),
    );
  }

  Widget _buildCardContents(String documentInfo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 233, 203, 8),
            Color.fromARGB(255, 191, 179, 15)
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPersonName(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.undo, color: Colors.white),
                      onPressed: () {
                        // Implementar lógica de eliminación
                        showPlatformDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            title: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromARGB(255, 0, 196, 13),
                                    Color.fromARGB(255, 1, 100, 13)
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'REACTIVAR ESTUDIANTE',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    '¿Deseas reactivar a ${student.names} ?',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 169, 6)),
                                ),
                                child: const Text("Reactivar"),
                                onPressed: () async {
                                  try {
                                    await api.activateStudent(student.id);
                                  } catch (error) {
                                    print(
                                        'Error al reactivar estudiante: $error');
                                  }
                                  Navigator.of(context).pop();

                                  // Recargar la página actual
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentInactive(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            _buildPersonLastNames(),
            const SizedBox(height: 10),
            _buildDocumentInfo(documentInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonName() {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.person, // Puedes elegir el icono que desees
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(width: 10),
        Text(
          '${student.names}',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonLastNames() {
    return Text(
      'Apellidos: ${student.last_name}',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDocumentInfo(String documentInfo) {
    return Row(
      children: [
        const Icon(
          Icons.person,
          color: Colors.white,
        ),
        Text(
          documentInfo,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
