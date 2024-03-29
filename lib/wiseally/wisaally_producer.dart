import 'package:budgetwise_ally_135/wiseally/wisaally_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WisaallyProducer {
  String listToString(List<String> characters) {
    String wisResult = '';
    for (int i = 0; i < characters.length; i++) {
      wisResult += characters[i];
    }
    return wisResult;
  }

  Future<WisaallyHive?> wisaallyLocalGet() async {
    final wisaallyLocal = await Hive.openBox<WisaallyHive>('wisaallyLocal');
    return wisaallyLocal.get('wisaallyLocal');
  }

  Future<void> wisaallyLocalSet(WisaallyHive wisaallyLocalGet) async {
    final wisaallyLocal = await Hive.openBox<WisaallyHive>('wisaallyLocal');
    await wisaallyLocal.put('wisaallyLocal', wisaallyLocalGet);
  }

  List<String> stringToList(String text) {
    List<String> wisResult = [];
    for (int i = 0; i < text.length; i++) {
      wisResult.add(text[i]);
    }
    return wisResult;
  }
}
