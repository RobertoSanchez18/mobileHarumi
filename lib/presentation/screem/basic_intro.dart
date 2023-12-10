import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/presentation/login/ingreso_login.dart';

class BasicIntro extends StatelessWidget {
  const BasicIntro({super.key});

  // Función para manejar la navegación cuando se presiona el botón
  void entrarLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.yellow],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.0,
                width: 250.0,
                child: Image.asset('assets/colegio_logo.png'),
              ),
              //const Text('APP MÓVIL', style: TextStyle(fontSize: 20, color: Colors.black)),
              const Text('APAFlex', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color.fromARGB(230, 172, 1, 1))),
              const Text('Sistematización de Ingresos y Egresos de APAFA', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0))),
              const SizedBox(height: 25),
              MaterialButton(
                onPressed: () {
                  // Llama a la función de navegación cuando se presiona el botón
                  entrarLogin(context);
                },
                color: const Color.fromARGB(230, 172, 1, 1),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                child: const Text('Ingresar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
