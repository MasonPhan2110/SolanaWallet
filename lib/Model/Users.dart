class Users {
  final int id;
  final String wallet;
  final String title;

  Users({required this.id, required this.wallet, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'wallet': wallet, 'title': title};
  }
}
