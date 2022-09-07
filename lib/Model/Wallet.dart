class Wallets {
  final String walletAddress;
  final String date;
  final String title;
  final String seedphrase;

  Wallets(
      {required this.walletAddress,
      required this.date,
      this.title = "",
      required this.seedphrase});

  Map<String, dynamic> toMap() {
    return {
      'walletAddress': walletAddress,
      'date': date,
      'title': title,
      'seedphrase': seedphrase
    };
  }
}
