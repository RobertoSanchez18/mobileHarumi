import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:t06_apaflex_am/List_Tabla/person/formulario.dart';
import 'package:t06_apaflex_am/model/person.dart';

import '../../presentation/service/personApi.dart';

class MaestroPerson extends StatefulWidget {
  const MaestroPerson({super.key});
  //const MaestroPerson({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<MaestroPerson> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final ApiService api = ApiService('http://10.0.2.2:8085/oraclecloud/v1');
  //final ApiService api = ApiService('http://localhost:8085/oraclecloud/v1/persons');
  List<Person> persons = [];
  List<Person> filteredLists = [];

  Future<void> fetchData() async {
    try {
      final data = await api.fetchData('persons/active');
      if (data is List) {
        setState(() {
          persons = data.map((item) => Person.fromJson(item)).toList();
          filteredLists = List.from(persons);
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  void filterData(String query) {
    setState(() {
      filteredLists = persons.where((person) {
        final personData = '${person.names} ${person.last_name}';
        return personData.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void eliminarPerson(Person person) {
    final personId = person.id;
    final endpoint = 'persons/inactive/$personId';
    api.eliminarPerson(endpoint, {}).then((response) {
      setState(() {
        persons.remove(person);
      });
    });
  }

  void reactivarPerson(Person person) {
    final personId = person.id;
    final endpoint = 'persons/active/$personId';
    api.reactivarPerson(endpoint, {}).then((response) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD0606),
        title: Text(
          'APODERADOS',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Encabezado de la página
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/colegio_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 242, 242),
              borderRadius: BorderRadius.circular(
                  20), // Ajusta el valor de aquí para hacer los bordes más redondos
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(31, 210, 116, 0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    //BARRA DE BUSQUEDA
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 136, 4, 4),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          onChanged: filterData,
                          decoration: const InputDecoration(
                            hintText: 'Buscar por nombre, Apellido',
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 128, 12, 8),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 13.0),
                          ),
                        ),
                      ),
                    ),

                    //BTN FORMULARIO
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 167, 13, 13),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormularioPerson(
                                api: api,
                                editarPerson: false,
                                person: null,
                                updateListado: null,
                                onSubmit: (newPerson) {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // LISTADO DE REGISTROS
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 16.0),
            child: ListView.builder(
              itemCount: filteredLists.length,
              itemBuilder: (context, index) {
                final person = filteredLists[index];
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Ajusta el valor de aquí para hacer los bordes más redondos
                    side: BorderSide(
                      color: Color.fromARGB(255, 153, 28, 5),
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.names,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          'Apellido: ${person.last_name}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        Text(
                          'Documento: ${person.type_documents_id}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormularioPerson(
                                      api: api,
                                      editarPerson: true,
                                      person: person,
                                      updateListado: null,
                                      onSubmit: (editPerson){
                                        Navigator.of(context).pop();
                                      }, 
                                    ),
                                  ),
                                );
                              },
                              child: Text('Editar',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                eliminarPerson(person);
                              },
                              child: Text('Eliminar',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                reactivarPerson(person);
                              },
                              child: Text('Reactivar',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
