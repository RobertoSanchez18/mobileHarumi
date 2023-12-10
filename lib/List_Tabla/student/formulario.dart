import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/List_Tabla/student/mostrar_tabla.dart';
import 'package:t06_apaflex_am/model/student.dart';
import 'package:t06_apaflex_am/services/StudentApi.dart';
import 'package:flutter/services.dart';

class FormularioStudent extends StatefulWidget {
  const FormularioStudent({Key? key}) : super(key: key);

  @override
  _FormularioStudentState createState() => _FormularioStudentState();
}

class _FormularioStudentState extends State<FormularioStudent> {
  String selectedDocumentType = 'DNI';
  String selectedAcademicLevel = 'Inicial';

  final _formKey = GlobalKey<FormState>();
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

//DATOS QUE ENVIA AL SERVICE PARA ENVIARLOS AL API
  Future<void> addStudent() async {
    // Recopila los datos del formulario
    final int personId = int.tryParse(person_idController.text) ?? 0;
    // final int documentTypeId =
    //     int.tryParse(document_type_idController.text) ?? 0;
    // final int academicDegreeId =
    //     int.tryParse(academic_degree_idController.text) ?? 0;

    final int documentTypeId = selectedDocumentType == 'DNI' ? 1 : 2;
    final int academicDegreeId = _getAcademicDegreeId();

    final Student student = Student(
      id: 0,
      person_id: personId,
      names: namesController.text,
      last_name: last_nameController.text,
      document_type_id: documentTypeId,
      number_document: number_documentController.text,
      email: emailController.text,
      cell_phone: cell_phoneController.text,
      academic_degree_id: academicDegreeId,
      states: "A",
    );

    try {
      // ignore: unused_local_variable
      final addedStudent = await api.saveStudent(student.toJson());

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Estudiante agregado con éxito.'),
        ),
      );

      // Después de mostrar el SnackBar, navegar a la página MaestroStudent
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MaestroStudent(),
          ),
        );
      });
    } catch (error) {
      // Imprime el error en la consola de depuración
      print('ERROR AL AGREGAR $error');
      // Aquí puedes manejar los errores, como mostrar un mensaje de error.
      // Por ejemplo:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERROR, revise los datos'),
        ),
      );
    }
  }

  int _getAcademicDegreeId() {
    switch (selectedAcademicLevel) {
      case 'Inicial':
        return 1;
      case 'Primaria':
        return 2;
      case 'Secundaria':
        return 3;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('AGREGAR ESTUDIANTE'),
          titleTextStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.039,
          ),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0), // Esto ocupa todo el ancho
            child: Container(
              color: Color.fromARGB(
                  255, 4, 41, 18), // Color de fondo personalizado
              height: 1, // Altura de la barra inferior
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: person_idController,
                    decoration: InputDecoration(
                      labelText: 'ID APODERADO:',
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
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType
                        .emailAddress, // Esto establece el teclado para correos electrónicos
                    decoration: InputDecoration(
                      hintText: 'CORREO',
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
                  DropdownButton<String>(
                    value: selectedDocumentType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDocumentType = newValue!;
                      });
                    },
                    items: <String>['DNI', 'CNE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: number_documentController,
                    decoration: const InputDecoration(
                        labelText: 'NUMERO DE DOCUMENTO:'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa tu Numero de Documento';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: cell_phoneController,
                    keyboardType: TextInputType
                        .phone, // Esto establece el teclado para ingresar solo números
                    decoration: InputDecoration(
                      hintText: 'CELULAR',
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
                  DropdownButton<String>(
                    value: selectedAcademicLevel,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAcademicLevel =
                            newValue ?? 'Inicial'; // Actualiza la variable
                      });
                    },
                    items: <String>['Inicial', 'Primaria', 'Secundaria']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  Container(
                    width: 150,
                    height: 39,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(207, 155, 10, 1),
                    ),
                    child: TextButton(
                      onPressed: () {
                        addStudent(); // Llama a la función que agrega el estudiante
                      },
                      child: const Text(
                        'Agregar Student',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
