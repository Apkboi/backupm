import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';


/// initialize local data storage

class HiveBoxes {
  static const cart = 'cart';
  static const storeBox = 'storeBox';
  static const userBox = 'user_box';

  static Future openAllBox() async {
    // myCartDao = MyCartDao();

    // await Hive.openBox(HiveStore.storeBox);
    await Future.wait([
      openBox(cart),
      openBox(storeBox),
      openBox(userBox),
    ]);
  }

  static Future clearAllBox() async {
    // await myCartDao!.truncate();

    // sl<UserImpDao>().truncate();

    // await Future.wait([
    //   closeBox(cart),
    //   closeBox(storeBox),
    //   closeBox(userBox),
    // ]);
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    Box<T> box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      try {
        box = await Hive.openBox<T>(boxName);
      } catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
        box = await Hive.openBox<T>(boxName);
      }
    }
    return box;
  }

  static Future<void> closeBox<T>(String boxName) async {
    Box box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
      box.close();
    }
  }

  static Future<void> clearData() async {
    await _clearBox<Map<String, dynamic>>('');
  }

  static Future<void> _clearBox<T>(String name) async {
    try {
      final Box<T> box = await openBox<T>(name);
      await box.clear();
    } catch (_) {
      debugPrint('clear $name error: ${_.toString()}');
    }
  }
}
