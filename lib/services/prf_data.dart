import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/resident_info.dart';
import '../models/response_apartment.dart';
import '../models/response_resident_own.dart';

@HiveType(typeId: 1, adapterName: "listapartment")
class ListOwn extends HiveObject {
  ListOwn({this.own});
  @HiveField(0)
  String? own;
}

// class ListOwnAdapter extends TypeAdapter<ListOwn> {
//   @override
//   ListOwn read(BinaryReader reader) {
//     var numOfFields = reader.readByte();
//     var fields = <int, dynamic>{
//       for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return ListOwn()..own = fields[0] as String;
//   }

//   @override
//   void write(BinaryWriter writer, ListOwn obj) {
//     writer.write(obj.own);
//   }

//   @override
//   // TODO: implement typeId
//   int get typeId => 1;
// }

class PrfData {
  static final PrfData shared = PrfData();

  final _userBox = Hive.box("USER");
  final _signIn = Hive.box('SIGNIN');
  final _settingBox = Hive.box("SETTINGS");
  final _apartmentBox = Hive.box("APARTMENTS");
  final _listApartmentBox = Hive.box("LISTAPARTMENTS");
  final __residentBox = Hive.box("RESIDENT");

  static Future open() async {
    await Hive.openBox("USER");
    await Hive.openBox("SIGNIN");
    await Hive.openBox("SETTINGS");
    await Hive.openBox("APARTMENTS");
    await Hive.openBox("LISTAPARTMENTS");
    await Hive.openBox("RESIDENT");
  }

  final String _tokenKey = "token";
  final String _languageKey = "language";
  //FloorPlan
  final String _floorPlan = "floorPlan";
  final String _apartment = "apartment";
  final String _resident = "resident";
  final String _listApartment = "listapartment";

  Future<void> deleteApartment() async {
    return await _apartmentBox.deleteAll([_floorPlan, _apartment]);
  }

  Future<void> setApartments(ResponseResidentOwn apartment) {
    return _apartmentBox.put(
        _apartment, jsonEncode(apartment.toJson()).toString());
  }

  ResponseResidentOwn? getApartments() {
    final data = _apartmentBox.get(_apartment);

    if (data != null) {
      final map = jsonDecode(data);
      return ResponseResidentOwn.fromJson(map);
    }
    return null;
  }

  Future<void> setResident(ResponseResidentInfo resident) {
    return __residentBox.put(
        _resident, jsonEncode(resident.toJson()).toString());
  }

  ResponseResidentInfo? getResident() {
    final data = __residentBox.get(_resident);

    if (data != null) {
      final map = jsonDecode(data);
      return ResponseResidentInfo.fromJson(map);
    }
    return null;
  }

  Future<void> deleteResident() async {
    return await __residentBox.deleteAll([_resident]);
  }

  Future<void> deleteListApartment() async {
    return await _listApartmentBox.deleteAll(
        List.generate(_listApartmentBox.length, (index) => index.toString()));
  }

  setListApartment(List<ResponseResidentOwn> list) {
    list.asMap().entries.forEach((e) async {
      await _listApartmentBox.put(
          e.key.toString(), jsonEncode(e.value.toJson()).toString());
    });
    return;
  }

  List<ResponseResidentOwn>? getListApratment() {
    List<ResponseResidentOwn> list = [];

    for (var i = 0; i < _listApartmentBox.length; i++) {
      list.add(ResponseResidentOwn.fromJson(
          jsonDecode(_listApartmentBox.get(i.toString()))));
    }
    return list;
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
