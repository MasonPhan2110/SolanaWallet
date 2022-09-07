class User {
  final int id;
  final String pass;

  User({required this.id, required this.pass});

  Map<String, dynamic> toMap() {
    return {'id': id, 'pass': pass};
  }
}
