class Student {
  final int id;
  final int person_id;
  final String names;
  final String last_name;
  final int document_type_id;
  final String number_document;
  final String email;
  final String cell_phone;
  final int academic_degree_id;
  final String states;

  Student({
    required this.id,
    required this.person_id,
    required this.names,
    required this.last_name,
    required this.document_type_id,
    required this.number_document,
    required this.email,
    required this.cell_phone,
    required this.academic_degree_id,
    required this.states,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      person_id: json['person_id'] ?? 0,
      names: json['names'] ?? '',
      last_name: json['last_name'] ?? '',
      document_type_id: json['document_type_id'] ?? 0,
      number_document: json['number_document'] ?? '',
      email: json['email'] ?? '',
      cell_phone: json['cell_phone'] ?? 0,
      academic_degree_id: json['academic_degree_id'] ?? 0,
      states: json['states'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_id': person_id,
      'names': names,
      'last_name': last_name,
      'document_type_id': document_type_id,
      'number_document': number_document,
      'email': email,
      'cell_phone': cell_phone,
      'academic_degree_id': academic_degree_id,
      'states': states,
    };
  }
}
