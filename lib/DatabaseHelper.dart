import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Model/User.dart';
import 'Model/Wallet.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'SolanaWallet.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE wallets(walletAddress TEXT PRIMARY KEY, date TEXT, title TEXT, seedphrase TEXT)");
      await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY, pass TEXT)");
    }, version: 1);
  }

  Future<void> addWallet(Wallets wallet) async {
    Database _db = await database();
    await _db.insert('wallets', wallet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addUser(User user) async {
    Database _db = await database();
    await _db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Wallets>> getWallets() async {
    Database _db = await database();
    List<Map<String, dynamic>> walletsMap = await _db.query('wallets');
    return List.generate(walletsMap.length, (index) {
      return Wallets(
        walletAddress: walletsMap[index]['walletAddress'],
        date: walletsMap[index]['date'],
        title: walletsMap[index]['title'],
        seedphrase: walletsMap[index]['seedphrase'],
      );
    });
  }

  Future<List<User>> getUsers() async {
    Database _db = await database();
    List<Map<String, dynamic>> usersMap = await _db.query('user');
    return List.generate(usersMap.length, (index) {
      return User(id: usersMap[index]['id'], pass: usersMap[index]['pass']);
    });
  }
}
