import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Metdo para listar
  Future<dynamic> fetchData(String endpoint) async {
    final client = http.Client();

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al cargar datos desde la API');
      }
    } finally {
      client.close(); // Cerrar el cliente después de usarlo.
    }
  }

  Future<dynamic> insertarData(String endpoint, Map<String, dynamic> data) async {
  final client = http.Client();

  try {
    final response = await client.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data), // Agrega los datos serializados al cuerpo de la solicitud
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar datos desde la API');
    }
  } finally {
    client.close();
  }
}


Future<void> eliminarPerson(String endpoint, Map<String, dynamic> data) async {
  final client = http.Client();

  try {
    final response = await client.delete(
      Uri.parse('$baseUrl/$endpoint'), // Modifica la URL según tu endpoint
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // La actualización fue exitosa
    } else {
      throw Exception('Error al actualizar la persona en la API');
    }
  } finally {
    client.close();
  }
}


Future<void> reactivarPerson(String endpoint, Map<String, dynamic> data) async {
  final client = http.Client();

  try {
    final response = await client.put(
      Uri.parse('$baseUrl/$endpoint'), // Modifica la URL según tu endpoint
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // La actualización fue exitosa
    } else {
      throw Exception('Error al actualizar la persona en la API');
    }
  } finally {
    client.close();
  }
}

Future<void> updatePerson(String endpoint, Map<String, dynamic> data) async {
  final client = http.Client();

  try {
    final response = await client.put(
      Uri.parse('$baseUrl/$endpoint'), // Modifica la URL según tu endpoint
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // La actualización fue exitosa
    } else {
      throw Exception('Error al actualizar la persona en la API');
    }
  } finally {
    client.close();
  }
}



  
}
