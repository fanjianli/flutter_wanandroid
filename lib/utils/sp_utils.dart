import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtils {
  static SpUtils _instance;
  static SharedPreferences _preferences;
  static Lock _lock = Lock();

  static Future<SpUtils> getInstance() async {
    if (_instance == null) {
      await _lock.synchronized(() async {
        if (_instance == null) {
          var singleton = SpUtils._();
          await singleton._init();
          _instance = singleton;
        }
      });
    }
    return _instance;
  }

  SpUtils._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  ///put object
  static Future<bool> putObject(String key, Object value) {
    if (null == _preferences) return null;
    return _preferences.setString(key, null == value ? "" : json.encode(value));
  }

  /// get obj.
  static T getObj<T>(String key, T f(Map v), {T defValue}) {
    if (null == _preferences) return null;
    Map map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map getObject(String key) {
    if (_preferences == null) return null;
    String _data = _preferences.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  ///put object list
  static Future<bool> putObjectList(String key, List<Object> list) {
    if (_preferences == null) return null;
    List<String> _dataLis = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _preferences.setStringList(key, _dataLis);
  }

  ///get Obj List
  static List<T> getObjList<T>(String key, T f(Map v),
      {List<T> defValue = const []}) {
    List<Map> dataList = getObjectList(key);
    List<T> list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  ///get Object List
  static List<Map> getObjectList(String key) {
    if (_preferences == null) return null;
    List<Map> list = _preferences.getStringList(key)?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
    return list;
  }



  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  /// get bool.
  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences.setBool(key, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences.setInt(key, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) {
    if (_preferences == null) return null;
    return _preferences.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_preferences == null) return defValue;
    return _preferences.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) {
    if (_preferences == null) return null;
    return _preferences.setStringList(key, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {Object defValue}) {
    if (_preferences == null) return defValue;
    return _preferences.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    if (_preferences == null) return null;
    return _preferences.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    if (_preferences == null) return null;
    return _preferences.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    if (_preferences == null) return null;
    return _preferences.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    if (_preferences == null) return null;
    return _preferences.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _preferences != null;
  }
}
