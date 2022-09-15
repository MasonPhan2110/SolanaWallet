import 'dart:convert';

import 'package:language_tool/language_tool.dart';
import 'package:http/http.dart' as http;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Setting/Config.dart';

import 'Model/Wallet.dart';

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
    final body = jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getBalance",
      "params": [walletAddress]
    });
    // Map<String, dynamic> body = {"jsonrpc":"2.0", "id":1, "method":"getBalance", "params":[walletAddress]};
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.post(Uri.parse("https://" + url.trim()),
        headers: header, body: body);
    var responseBody = jsonDecode(response.body);
    double balance = (responseBody['result']['value'] / decimals).toDouble();
    return balance;
  }

  Future<void> requestAirdrop(String walletAddress, int amount) async {
    amount = amount * decimals;
    var url = "api.devnet.solana.com ";
    var client = http.Client();
    final body = jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "requestAirdrop",
      "params": [walletAddress, amount]
    });
    // Map<String, dynamic> body = {"jsonrpc":"2.0", "id":1, "method":"getBalance", "params":[walletAddress]};
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.post(Uri.parse("https://" + url.trim()),
        headers: header, body: body);
    print(response.body);
  }
  Future<String> getSignatureForAddress() async{
    var url = "api.devnet.solana.com ";
    final body = jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getSignaturesForAddress",
      "params": ["Cpze2SgPopS2SjhdCtPuzeUu36jGkq3u7U5BYnMdFFjb", {"limit":1}]
    });
    Map<String, String> header = {"Content-Type": "application/json"};
    var response = await http.post(Uri.parse("https://" + url.trim()),
        headers: header, body: body);
    print(response.body);
    var responseBody = jsonDecode(response.body);
    String signature = responseBody['result'][0]['signature'];
    return signature;
  }
  Future<void> sendTransaction(String to, double amount) async {
    amount = amount * decimals;
    List<Wallets> listWallets = await DatabaseHelper().getWallets();
    final seed = listWallets[0].seedphrase;
    final signer = await Ed25519HDKeyPair.fromMnemonic(seed);
    final transfer = SystemInstruction.transfer(
      fundingAccount: signer.publicKey,
      recipientAccount: Ed25519HDPublicKey.fromBase58(to),
      lamports: amount.toInt(),
    );
    final message = Message.only(transfer);
    final fee = await SolanaClient(
        rpcUrl: Uri.parse("https://api.devnet.solana.com"),
        websocketUrl: Uri.parse("wss://api.devnet.solana.com/"))
        .rpcClient.getFees();
    print(fee.feeCalculator.lamportsPerSignature);
    await SolanaClient(
        rpcUrl: Uri.parse("https://api.devnet.solana.com"),
        websocketUrl: Uri.parse("wss://api.devnet.solana.com/"))
        .rpcClient.signAndSendTransaction(message, <Ed25519HDKeyPair>[signer]);
  }
}
