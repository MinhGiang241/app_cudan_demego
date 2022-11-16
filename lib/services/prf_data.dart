import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/response_apartment.dart';

class PrfData {
  static final PrfData shared = PrfData();
  final _userBox = Hive.box("USER");
  final _signIn = Hive.box('SIGNIN');
  final _settingBox = Hive.box("SETTINGS");
  final _apartmentBox = Hive.box("APARTMENTS");

  static Future open() async {
    await Hive.openBox("USER");
    await Hive.openBox("SIGNIN");
    await Hive.openBox("SETTINGS");
    await Hive.openBox("APARTMENTS");
  }

  final String _tokenKey = "token";
  final String _languageKey = "language";
  //FloorPlan
  final String _floorPlan = "floorPlan";
  final String _apartment = "apartment";

  Future<void> deleteApartment() async {
    return await _apartmentBox.deleteAll([_floorPlan, _apartment]);
  }

  Future<void> setApartments(ResponseApartment apartment) {
    return _apartmentBox.put(
        _apartment, jsonEncode(apartment.toJson()).toString());
  }

  ResponseApartment? getApartments() {
    final data = _apartmentBox.get(_apartment);

    if (data != null) {
      final map = jsonDecode(data);
      return ResponseApartment.fromJson(map);
    }
    return null;
  }

  Future<void> setFloorPlan(FloorPlan floorPlan) {
    return _apartmentBox.put(
        _floorPlan, jsonEncode(floorPlan.toJson()).toString());
  }

  FloorPlan? getFLoorPlan() {
    final data = _apartmentBox.get(_floorPlan);

    if (data != null) {
      final map = jsonDecode(data);
      return FloorPlan.fromJson(map);
    }
    return null;
  }

  Future<void> setToken(String token) async {
    return _userBox.put(_tokenKey, token);
  }

  Future<void> setSignInStore(String user, String password) async {
    await _signIn.put("acc", user);
    await _signIn.put("pass", password);
  }

  getSignInStore() async {
    var acc = await _signIn.get("acc");
    var pass = await _signIn.get("pass");

    return {"acc": acc, 'pass': pass};
  }

  Future<void> deteleSignInStore() async {
    await _signIn.deleteAll(["acc", 'pass']);
  }

  String? getToken() {
    return _userBox.get(_tokenKey);
  }

  Future<void> deleteUser() async {
    return await _userBox.deleteAll([_tokenKey]);
  }

  Future<void> setLanguage(int lang) async {
    return _settingBox.put(_languageKey, lang);
  }

  int? getLanguage() {
    return _userBox.get(_languageKey);
  }
}
