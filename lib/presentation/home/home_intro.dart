import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/List_Tabla/person/mostrar_tabla.dart';
import 'package:t06_apaflex_am/List_Tabla/student/mostrar_tabla.dart';

class HomeIntro extends StatelessWidget {
  const HomeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colegio Alfonso Ugarte N°20191'),
        backgroundColor:
            const Color.fromARGB(232, 209, 6, 6), // Color de fondo de la barra de navegación
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
                    MaterialPageRoute(builder: (context) => const MaestroPerson()),
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
      body: const Center(
        child: Text('Contenido de la pantalla principal'),
      ),
    );
  }
}
