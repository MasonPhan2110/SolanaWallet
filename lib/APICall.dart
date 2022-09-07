import 'package:language_tool/language_tool.dart';

class APICall {
  Future<bool> checkSpell(String str) async {
    var tool = LanguageTool();
    var result = await tool.check(str);
    return result.isEmpty;
  }
}
