import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/model/person.dart';
import 'package:t06_apaflex_am/presentation/service/personApi.dart';

class FormularioPerson extends StatefulWidget {
  final ApiService api;
  final bool editarPerson;
  final Function? updateListado;
  final Person? person;
  final void Function(Person) onSubmit;
  const FormularioPerson(
      {super.key,
      required this.api,
      this.person,
      required this.onSubmit,
      required this.updateListado, required this.editarPerson});

  @override
  PersonFormState createState() => PersonFormState();
}

class PersonFormState extends State<FormularioPerson> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namesController = TextEditingController();
  final TextEditingController last_nameController = TextEditingController();
  final TextEditingController type_documents_idController = TextEditingController();
  final TextEditingController number_documentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cell_phoneController = TextEditingController();
  final TextEditingController sex_idController = TextEditingController();

  //final TextEditingController statesController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.person != null) {
      namesController.text = widget.person!.names;
      last_nameController.text = widget.person!.last_name;
      type_documents_idController.text = widget.person!.type_documents_id.toString();
      number_documentController.text = widget.person!.number_document;
      cell_phoneController.text = widget.person!.cell_phone;
      emailController.text = widget.person!.email;
      sex_idController.text = widget.person!.sex_id.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('person Nuevo'),
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
              color: Color.fromARGB(255, 149, 12, 5), // Color de fondo personalizado
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
                    controller: namesController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa un nombre';
                      }
                      return null;
                    },
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  TextFormField(
                    controller: last_nameController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa un apellido';
                      }
                      return null;
                    },
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  TextFormField(
                    controller: type_documents_idController,
                    decoration:
                        const InputDecoration(labelText: 'Tipo de Documento'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa tu Tipo de Documento';
                      }
                      return null;
                    },
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  TextFormField(
                    controller: number_documentController,
                    decoration:
                        const InputDecoration(labelText: 'Numero de Documento'),
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

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  TextFormField(
                    controller: cell_phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Número de Celular'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa tu celular';
                      }
                      return null;
                    },
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  TextFormField(
                    controller: sex_idController,
                    decoration: const InputDecoration(labelText: 'sexo'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por Favor ingresa tu sexo';
                      }
                      return null;
                    },
                  ),

                  //Espacio entre FORM Y BTN GUARDAR
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          'names': namesController.text,
                          'last_name': last_nameController.text,
                          'type_documents_id': type_documents_idController.text,
                          'number_document': number_documentController.text,
                          'cell_phone': cell_phoneController.text,
                          'sex_id': sex_idController.text,
                          'states': 'A',
                        };
                        // crear una persona

                        if (widget.person!= null) {
                          widget.api.updatePerson('persons/${widget.person!.id}',data);
                        } else {
                          // Si no hay una persona existente, entonces estamos creando una nueva
                          widget.api
                              .insertarData('persons', data);
                              
                        }

                        // Cerrar el Formulario
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 214, 4, 4)),
                    child: const Text('Guardar Persona'),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
