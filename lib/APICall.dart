import 'dart:convert';

import 'package:language_tool/language_tool.dart';
import 'package:http/http.dart' as http;
import 'package:walletsolana/Setting/Config.dart';

class APICall {
  Config config = Config();
  int decimals = 1000000000;
  Future<bool> checkSpell(String str) async {
    var tool = LanguageTool();
    var result = await tool.check(str);
    return result.isEmpty;
  }
  Future<double> getBalance(String walletAddress) async {
    var url = "api.devnet.solana.com ";
    var client = http.Client();
    final body = jsonEncode({"jsonrpc":"2.0", "id":1, "method":"getBalance", "params":[walletAddress]});
    // Map<String, dynamic> body = {"jsonrpc":"2.0", "id":1, "method":"getBalance", "params":[walletAddress]};
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.post(Uri.parse("https://"+url.trim()),headers: header,body: body);
    var responseBody = jsonDecode(response.body);
    double balance = (responseBody['result']['value'] / decimals).toDouble();
    return balance;
  }

  Future<void> requestAirdrop(String walletAddress, int amount) async {
    amount = amount * decimals;
    var url = "api.devnet.solana.com ";
    var client = http.Client();
    final body = jsonEncode({"jsonrpc":"2.0", "id":1, "method":"requestAirdrop", "params":[walletAddress,amount]});
    // Map<String, dynamic> body = {"jsonrpc":"2.0", "id":1, "method":"getBalance", "params":[walletAddress]};
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.post(Uri.parse("https://"+url.trim()),headers: header,body: body);
    print(response.body);
  }
}
