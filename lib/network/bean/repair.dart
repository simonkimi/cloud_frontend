import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class RepairBean extends PaginationBase<RepairResults> {
  RepairBean({
    int count,
    Object next,
    Object previous,
    List<RepairResults> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory RepairBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<RepairResults> results =
        jsonRes['results'] is List ? <RepairResults>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results.add(RepairResults.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return RepairBean(
      count: asT<int>(jsonRes['count']),
      next: asT<Object>(jsonRes['next']),
      previous: asT<Object>(jsonRes['previous']),
      results: results,
    );
  }

  int _count;

  @override
  int get count => _count;
  Object _next;

  @override
  String get next => _next;
  String _previous;

  @override
  String get previous => _previous;
  List<RepairResults> _results;

  @override
  List<RepairResults> get results => _results;

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

class RepairResults {
  RepairResults({
    String name,
    int createTime,
  })  : _name = name,
        _createTime = createTime;

  factory RepairResults.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : RepairResults(
              name: asT<String>(jsonRes['name']),
              createTime: asT<int>(jsonRes['create_time']),
            );

  String _name;

  String get name => _name;
  int _createTime;

  int get createTime => _createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': _name,
        'create_time': _createTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
