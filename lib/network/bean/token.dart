import 'dart:convert' show json;

import '../utils.dart';

class TokenBean {
  TokenBean({
    this.token,
  });

  factory TokenBean.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : TokenBean(
          token: asT<String>(jsonRes['token']),
        );

  String token;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
