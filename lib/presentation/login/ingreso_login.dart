import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/presentation/home/home_intro.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // Función para manejar la navegación cuando se presiona el botón
  void entrarHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeIntro(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _singup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'APAFlex',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(230, 172, 1, 1)),
        ),
        Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
            '"Bienvenido/a, APAFlex es un aplicativo móvil basado en la gestión de APAFA y que ahora se quiere Sistematizar para mejorar el proceso de Gestión en la institución educativa"',
            textAlign: TextAlign.center)
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Usuario",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 14),
        TextField(
          decoration: InputDecoration(
              hintText: "Contraseña",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            // Llama a la función de navegación cuando se presiona el botón
            entrarHome(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          child: const Text(
            'Ingresar',
            style: TextStyle(fontSize: 20, color: Color.fromARGB(204, 59, 25, 180)),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {}, child: const Text('¿Olvidaste tu contraseña?'));
  }

  _singup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿No cuentas con un usuario?'),
        TextButton(onPressed: () {}, child: const Text('Crear'))
      ],
    );
  }
}
