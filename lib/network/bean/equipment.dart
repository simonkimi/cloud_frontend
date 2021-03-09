import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class EquipmentBean extends PaginationBase<EquipmentResults> {
  EquipmentBean({
    int count,
    String next,
    String previous,
    List<EquipmentResults> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory EquipmentBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<EquipmentResults> results =
        jsonRes['results'] is List ? <EquipmentResults>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results
              .add(EquipmentResults.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return EquipmentBean(
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
  List<EquipmentResults> _results;

  @override
  List<EquipmentResults> get results => _results;

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

class EquipmentResults {
  EquipmentResults({
    int cid,
    int createTime,
  })  : _cid = cid,
        _createTime = createTime;

  factory EquipmentResults.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : EquipmentResults(
              cid: asT<int>(jsonRes['cid']),
              createTime: asT<int>(jsonRes['create_time']),
            );

  int _cid;

  int get cid => _cid;
  int _createTime;

  int get createTime => _createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cid': _cid,
        'create_time': _createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
