import 'package:hive_flutter/hive_flutter.dart';

part 'wisaally_hive.g.dart';

@HiveType(typeId: 4)
class WisaallyHive extends HiveObject {
  @HiveField(0)
  String regwisaally;
  @HiveField(1)
  String logwisaally;
  @HiveField(2)
  String cabwisaally;
  @HiveField(3)
  bool strtwisaally;

  WisaallyHive({
    required this.strtwisaally,
    required this.cabwisaally,
    required this.logwisaally,
    required this.regwisaally,
  });
}
