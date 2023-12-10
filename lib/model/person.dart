class Person {
  final int id;
  final String names;
  final String last_name;
  final int type_documents_id;
  final String number_document;
  final String email;
  final String cell_phone;
  final int sex_id;
  final String states;

  Person({
    required this.id,
    required this.names,
    required this.last_name,
    required this.type_documents_id,
    required this.number_document,
    required this.email,
    required this.cell_phone,
    required this.sex_id,
    required this.states,
    
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      names: json['names'],
      last_name: json['last_name'],
      type_documents_id: json['type_documents_id'],
      number_document: json['number_document'],
      email: json['email'],
      cell_phone: json['cell_phone'],
      sex_id: json['sex_id'],
      states: json['states'],
      
    );
  }
}