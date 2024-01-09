import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'hive_manager.dart';

class HiveStore {
  // static const storeBox = '_storeBox';
  static const cart = 'cart';
  static const user = 'user_data';

  final Box<dynamic> _box = Hive.box(HiveBoxes.storeBox);

  // Future<void> call() async {
  //   Future.delayed(Duration.zero, () async {
  //     // await Hive.initFlutter();
  //
  //     _box = await Hive.openBox(HiveStore.storeBox);
  //   });
  // }
  //
  // Future<void> openBox() async {
  //   _box = await Hive.openBox(HiveStore.storeBox);
  // }

  getValue<T>(Object key, {T? defaultValue}) => _box.get(
        key,
        defaultValue: defaultValue,
      ) as T?;

  Future<void> setValue<T>(Object key, T value) async =>
      await _box.put(key, value);

  Future<void> deleteValue<T>(Object key) async => await _box.delete(key);

  Future<void> clearAll() async => await _box.clear();

  ValueListenable<Box> getListenable({List<String>? keys}) {
    return keys == null ? _box.listenable() : _box.listenable(keys: keys);
  }
}
