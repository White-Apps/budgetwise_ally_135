import 'package:budgetwise_ally_135/wiseally/wisaally_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WisaallyProducer {
  Future<WisaallyHive?> wisaallyLocalGet() async {
    final wisaallyLocal = await Hive.openBox<WisaallyHive>('wisaallyLocal');
    return wisaallyLocal.get('wisaallyLocal');
  }

  Future<void> wisaallyLocalSet(WisaallyHive wisaallyLocalGet) async {
    final wisaallyLocal = await Hive.openBox<WisaallyHive>('wisaallyLocal');
    await wisaallyLocal.put('wisaallyLocal', wisaallyLocalGet);
  }
}
