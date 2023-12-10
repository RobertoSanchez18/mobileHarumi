import 'dart:convert';
import 'package:t06_apaflex_am/model/student.dart';
import 'package:http/http.dart' as http;

class StudentApi {
  final String baseUrl;

  StudentApi(this.baseUrl);

//METODO ACTUALIZAR Y AGREGAR
  Future<Student> saveStudent(Map<String, dynamic> studentData) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      body: jsonEncode(studentData),
      headers: {
        'Content-Type':
            'application/json', // Configura el tipo de contenido a JSON
      },
    );
    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to save student: ${response.statusCode} - ${response.body}');
    }
  }

//METODO ACTIVAR ESTADO "A"
  Future<Student> activateStudent(int id) async {
    final response = await http.put(Uri.parse('$baseUrl/activate/$id'));
    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to activate student');
    }
  }

//METODO INACTIVAR ESTADO "I"
  Future<Student> inactivateStudent(int id) async {
    final url = Uri.parse('$baseUrl/deactivate/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to inactivate student');
    }
  }
}

final api = StudentApi("http://192.168.88.8:8085/oraclecloud/v1/students");
