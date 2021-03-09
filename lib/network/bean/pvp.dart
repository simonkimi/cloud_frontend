import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class PvpBean extends PaginationBase<PvpResults> {
  PvpBean({
    int count,
    String next,
    String previous,
    List<PvpResults> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory PvpBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<PvpResults> results =
        jsonRes['results'] is List ? <PvpResults>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results.add(PvpResults.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return PvpBean(
      count: asT<int>(jsonRes['count']),
      next: asT<String>(jsonRes['next']),
      previous: asT<String>(jsonRes['previous']),
      results: results,
    );
  }

  int _count;

  @override
  int get count => _count;
  String _next;

  @override
  String get next => _next;
  String _previous;

  @override
  String get previous => _previous;
  List<PvpResults> _results;

  @override
  List<PvpResults> get results => _results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': _count,
        'next': _next,
        'previous': _previous,
        'results': _results,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PvpResults {
  PvpResults({
    String username,
    int uid,
    String ships,
    int result,
    int createTime,
  })  : _username = username,
        _uid = uid,
        _ships = ships,
        _result = result,
        _createTime = createTime;

  factory PvpResults.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : PvpResults(
          username: asT<String>(jsonRes['username']),
          uid: asT<int>(jsonRes['uid']),
          ships: asT<String>(jsonRes['ships']),
          result: asT<int>(jsonRes['result']),
          createTime: asT<int>(jsonRes['create_time']),
        );

  String _username;

  String get username => _username;
  int _uid;

  int get uid => _uid;
  String _ships;

  String get ships => _ships;
  int _result;

  int get result => _result;
  int _createTime;

  int get createTime => _createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': _username,
        'uid': _uid,
        'ships': _ships,
        'result': _result,
        'create_time': _createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PvpStatistic {
  PvpStatistic({
    int ss,
    int s,
    int a,
    int b,
    int c,
    int d,
  })  : _ss = ss,
        _s = s,
        _a = a,
        _b = b,
        _c = c,
        _d = d;

  factory PvpStatistic.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : PvpStatistic(
          ss: asT<int>(jsonRes['ss']),
          s: asT<int>(jsonRes['s']),
          a: asT<int>(jsonRes['a']),
          b: asT<int>(jsonRes['b']),
          c: asT<int>(jsonRes['c']),
          d: asT<int>(jsonRes['d']),
        );

  int _ss;

  int get ss => _ss;
  int _s;

  int get s => _s;
  int _a;

  int get a => _a;
  int _b;

  int get b => _b;
  int _c;

  int get c => _c;
  int _d;

  int get d => _d;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ss': _ss,
        's': _s,
        'a': _a,
        'b': _b,
        'c': _c,
        'd': _d,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
