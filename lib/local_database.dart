import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static Box? data;

  static Future init() async {
    await Hive.initFlutter();
    data = await Hive.openBox("screenTimeData");
  }

  static Future<int> getTime(String name) async {
    return (await data!.get(name) as int?) ??
        DateTime.now().millisecondsSinceEpoch;
  }

  static Future saveTime(String name) async {
    await data!.put(name, DateTime.now().millisecondsSinceEpoch);
  }

  static Future clearData() async {
    if (data != null) {
      await data!.clear();
    }
  }
}
