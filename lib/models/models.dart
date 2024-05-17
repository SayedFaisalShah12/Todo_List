class NoteModel {
  int? id;
  String title;
  String description;
  String email;
  var age;

  NoteModel(
      {this.id, required this.title, required this.description, required this.email, required this.age});

  NoteModel.fromMap(Map<String, dynamic> map):
        id = map['id'],
        title = map['title'],
        description = map['description'],
        email = map['email'],
        age = map['age'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'email': email,
      'age': age,
    };
  }
}
