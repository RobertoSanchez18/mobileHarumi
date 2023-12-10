import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:t06_apaflex_am/List_Tabla/person/mostrar_tabla.dart';
//import 'package:http/http.dart';
import 'package:t06_apaflex_am/List_Tabla/student/formulario.dart';
import 'package:t06_apaflex_am/model/student.dart';
import 'package:t06_apaflex_am/services/StudentApi.dart';
import 'package:http/http.dart' as http;
import 'package:t06_apaflex_am/List_Tabla/student/studentInactivos.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(MaestroStudent());
}

class MaestroStudent extends StatefulWidget {
  MaestroStudent({Key? key}) : super(key: key);
  //const MaestroStudent({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StudentState createState() => _StudentState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText =
        newValue.text?.toUpperCase() ?? ''; // Convierte a mayúsculas
    String filteredText = newText.replaceAll(
        RegExp(r'[^A-Z\s]'), ''); // Filtra solo letras mayúsculas y espacios

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class _StudentState extends State<MaestroStudent> {
  final url =
      Uri.parse("http://192.168.88.8:8085/oraclecloud/v1/students/activate");
  late List<Student> students = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    getStudents();
  }

  void deleteStudent(int studentId) async {
    try {
      await api.inactivateStudent(studentId);
      // Eliminación exitosa, actualiza la lista de estudiantes
      setState(() {
        students.removeWhere((student) => student.id == studentId);
      });
    } catch (error) {
      print('Error al eliminar student: $error');
    }
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
              print('Error al decodificar un student: $e');
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Ícono de hamburguesa
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
            );
          },
        ),
        title: const Text('ESTUDIANTE ACTIVOS'),
        backgroundColor: const Color(0xFFBD0606),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Colors.white,
                size:
                    35), // Tamaño personalizado (ajústalo según tus preferencias)
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentInactive(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 169, 13, 2), // fondo del menú
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 133, 0, 0), //encabezado
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Colegio Alfonso Ugarte N°20191',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/colegio_logo.png', //logotipo
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              // Opciones del menú
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de Dashboard
                  Navigator.pop(context); // Cierra el menú
                  // Implementa la navegación a la pantalla de Dashboard aquí
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: const Text(
                  'Apoderado',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de Perfil
                  // Navegar a otra página
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MaestroPerson()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.school,
                  color: Colors.white,
                ),
                title: const Text(
                  'Estudiante',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de Perfil
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MaestroStudent()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: const Text(
                  'Activity',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de Perfil
                  Navigator.pop(context); // Cierra el menú
                  // Implementa la navegación a la pantalla de Perfil aquí
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: const Text(
                  'Worker',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de Perfil
                  Navigator.pop(context); // Cierra el menú
                  // Implementa la navegación a la pantalla de Perfil aquí
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre o apellido',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      // Filtrar estudiantes por nombre o apellido según el query ingresado
                      List<Student> filteredStudents =
                          students.where((student) {
                        // Verificar si el nombre o apellido contiene el query (ignorar mayúsculas y minúsculas)
                        return student.names
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            (student.last_name != null &&
                                student.last_name
                                    .toLowerCase()
                                    .contains(query.toLowerCase()));
                      }).toList();
                      setState(() {
                        students = filteredStudents;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 171, 0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioStudent(
                              // api: api,
                              // editarStudent: false,
                              // student: null,
                              // updateListado:
                              //     filterData, // Pasa la función de carga aquí
                              // onSubmit: (newStudent) {
                              //   Navigator.of(context).pop();
                              // },
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // LISTADO DE REGISTROS
          students.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      students
                          .sort((a, b) => a.last_name.compareTo(b.last_name));
                      print('Building item $index');
                      return StudentCard(
                        student: students[index],
                        onEditPressed: () {},
                        onDeletePressed: () {
                          deleteStudent(students[index].id);
                        },
                        context: context,
                      );
                    },
                  ),
                ),
        ],
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
    required Null Function() onDeletePressed,
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
            color: Color.fromARGB(255, 4, 75, 105), width: 2.0),
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
            Color.fromARGB(255, 0, 179, 255),
            Color.fromARGB(255, 0, 140, 200),
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
                _buildStudentName(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return EditStudentModal(student: student);
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        //MODAL PARA ELIMINAR
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
                                    Color.fromARGB(255, 242, 66, 66),
                                    Color(0xFFF50909)
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Eliminar Estudiante',
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
                                    '¿Deseas Eliminar a ${student.names} ?',
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
                                    const Color.fromARGB(255, 255, 17, 0),
                                  ),
                                ),
                                child: const Text("Eliminar"),
                                onPressed: () async {
                                  try {
                                    await api.inactivateStudent(student.id);
                                  } catch (error) {
                                    print(
                                        'Error al eliminar estudiante: $error');
                                  }

                                  Navigator.of(context).pop();

                                  // Recargar la página actual
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MaestroStudent(),
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
            _buildStudentLastNames(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentName() {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.school,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(width: 10),
        Text(
          '${student.names}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentLastNames() {
    return Text(
      'Apellidos: ${student.last_name}',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}

class EditStudentModal extends StatefulWidget {
  final Student student;

  EditStudentModal({required this.student});

  @override
  _EditStudentModalState createState() => _EditStudentModalState();
}

class _EditStudentModalState extends State<EditStudentModal> {
  String selectedDocumentType = 'DNI';
  String selectedAcademicLevel = 'Inicial';

  // Define controladores para los campos del formulario
  final TextEditingController idController = TextEditingController();
  final TextEditingController person_idController = TextEditingController();
  final TextEditingController namesController = TextEditingController();
  final TextEditingController last_nameController = TextEditingController();
  final TextEditingController document_type_idController =
      TextEditingController();
  final TextEditingController number_documentController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cell_phoneController = TextEditingController();
  final TextEditingController academic_degree_idController =
      TextEditingController();
  final TextEditingController statesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales del personal
    idController.text = widget.student.id.toString();
    person_idController.text = widget.student.person_id.toString();
    namesController.text = widget.student.names;
    last_nameController.text = widget.student.last_name;
    document_type_idController.text =
        widget.student.document_type_id.toString();
    number_documentController.text = widget.student.number_document;
    emailController.text = widget.student.email;
    cell_phoneController.text = widget.student.cell_phone;
    academic_degree_idController.text =
        widget.student.academic_degree_id.toString();
    statesController.text = widget.student.states;

    selectedDocumentType = widget.student.document_type_id.toString();
  }

  String _getAcademicLevel(int academicDegreeId) {
    switch (academicDegreeId) {
      case 1:
        return 'Inicial';
      case 2:
        return 'Primaria';
      case 3:
        return 'Secundaria';
      default:
        return 'Inicial'; // Valor predeterminado (puedes ajustarlo según tus necesidades)
    }
  }

  int _getAcademicDegreeId(String academicLevel) {
    switch (academicLevel) {
      case 'Inicial':
        return 1;
      case 'Primaria':
        return 2;
      case 'Secundaria':
        return 3;
      default:
        return 1; // Valor predeterminado (puedes ajustarlo según tus necesidades)
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        return Container(
          color: Color.fromARGB(255, 185, 21, 21),
          child: Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 2.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('EDITAR ESTUDIANTE'),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: person_idController,
                      decoration: InputDecoration(
                        labelText: 'ID APODERADO',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[^\d]')), // Acepta solo números
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: namesController,
                      decoration: InputDecoration(
                        labelText: 'NOMBRES:',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'[A-ZÑ\s]')), // Acepta letras mayúsculas y la letra Ñ junto con espacios
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[0-9]')), // Evita números
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: last_nameController,
                      decoration: InputDecoration(
                        labelText: 'APELLIDOS:',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'[A-ZÑ\s]')), // Acepta letras mayúsculas y la letra Ñ junto con espacios
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[0-9]')), // Evita números
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedDocumentType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDocumentType = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'TIPO DE DOCUMENTO',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('DNI'),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text('CNE'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: number_documentController,
                      keyboardType: TextInputType
                          .number, // Configura el teclado para ingresar solo números
                      decoration: InputDecoration(
                        labelText: 'NUMERO DE DOCUMENTO',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible:
                          false, // Cambia a `true` si quieres que sea visible durante el desarrollo.
                      child: TextFormField(
                        controller: statesController,
                        decoration: const InputDecoration(labelText: 'Estado'),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType
                          .emailAddress, // Esto establece el teclado para correos electrónicos
                      decoration: InputDecoration(
                        hintText: 'CORREO ELECTRONICO',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: cell_phoneController,
                      keyboardType: TextInputType
                          .phone, // Esto establece el teclado para ingresar solo números
                      decoration: InputDecoration(
                        hintText: 'NUMERO DE CELULAR',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value:
                          int.tryParse(academic_degree_idController.text) ?? 1,
                      onChanged: (newValue) {
                        setState(() {
                          academic_degree_idController.text =
                              newValue.toString();
                          selectedAcademicLevel = newValue.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'NIVEL ACADEMICO',
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 0, 0),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(36, 117, 44, 1),
                            width: 4.0,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('Inicial'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('Primaria'),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('Secundaria'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Obtener los valores actualizados del formulario
                        final updatedStudentData = {
                          'id': int.parse(idController.text),
                          'person_id': person_idController.text,
                          'names': namesController.text,
                          'last_name': last_nameController.text,
                          'document_type_id': document_type_idController.text,
                          'number_document': number_documentController.text,
                          'email': emailController.text,
                          'cell_phone': cell_phoneController.text,
                          'academic_degree_id':
                              academic_degree_idController.text,
                          'states': statesController.text,
                        };

                        // Llamar a la función para guardar/actualizar al estudiante
                        api
                            .saveStudent(updatedStudentData)
                            .then((updatedStudent) {
                          // Actualizar la UI o realizar cualquier acción adicional
                          Navigator.of(context).pop(); // Cierra el modal
                          // Recargar la página actual
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaestroStudent(),
                            ),
                          );
                        }).catchError((error) {
                          // Manejar errores de guardar/actualizar
                          print('Error al guardar estudiante: $error');
                        });
                      },
                      child: const Text('Guardar Cambios'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
