import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class BuildBean extends PaginationBase<BuildResults> {
  BuildBean({
    int count,
    String next,
    String previous,
    List<BuildResults> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory BuildBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<BuildResults> results =
        jsonRes['results'] is List ? <BuildResults>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results.add(BuildResults.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return BuildBean(
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
  List<BuildResults> _results;

  @override
  List<BuildResults> get results => _results;

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

class BuildResults {
  BuildResults({
    int cid,
    String name,
    int createTime,
    bool isNew,
  })  : _cid = cid,
        _name = name,
        _createTime = createTime,
        _isNew = isNew;

  factory BuildResults.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : BuildResults(
          cid: asT<int>(jsonRes['cid']),
          name: asT<String>(jsonRes['name']),
          createTime: asT<int>(jsonRes['create_time']),
          isNew: asT<bool>(jsonRes['is_new']),
        );

  int _cid;

  int get cid => _cid;
  String _name;

  String get name => _name;
  int _createTime;

  int get createTime => _createTime;
  bool _isNew;

  bool get isNew => _isNew;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cid': _cid,
        'name': _name,
        'create_time': _createTime,
        'is_new': _isNew,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
