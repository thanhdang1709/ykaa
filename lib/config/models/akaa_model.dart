import 'dart:core';

const String table = 'akaa';

class AkaaFiles {
  static final List<String> values = [
    id,
    account,
    atm,
    momo,
    zalo,
  ];
  static const String id = 'id';
  static const String account = 'account';
  static const String atm = 'atm';
  static const String zalo = 'zalo';
  static const String momo = 'momo';
}

class AkaaModel {
  int id;
  String account;
  String atm;
  String momo;
  String zalo;

  AkaaModel({
    this.id,
    this.account,
    this.atm,
    this.momo,
    this.zalo,
  });

  AkaaModel copy({
    int id,
    String account,
    String atm,
    String momo,
    String zalo,
  }) =>
      AkaaModel(
        id: id ?? this.id,
        account: account ?? this.account,
        atm: atm ?? this.atm,
        momo: momo ?? this.momo,
        zalo: zalo ?? this.zalo,
      );

  static AkaaModel fromJson(Map<String, Object> json) => AkaaModel(
        id: json[AkaaFiles.id] as int,
        account: json[AkaaFiles.account] as String,
        atm: json[AkaaFiles.atm] as String,
        momo: json[AkaaFiles.momo] as String,
        zalo: json[AkaaFiles.zalo] as String,
      );

  Map<String, Object> toJson() => {
        AkaaFiles.id: id,
        AkaaFiles.account: account,
        AkaaFiles.atm: atm,
        AkaaFiles.zalo: zalo,
        AkaaFiles.momo: momo,
      };
}
