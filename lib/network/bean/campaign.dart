import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class CampaignBean extends PaginationBase<CampaignResults> {
  CampaignBean({
    int count,
    String next,
    String previous,
    List<CampaignResults> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory CampaignBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<CampaignResults> results =
        jsonRes['results'] is List ? <CampaignResults>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results
              .add(CampaignResults.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return CampaignBean(
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
  List<CampaignResults> _results;

  @override
  List<CampaignResults> get results => _results;

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

class CampaignResults {
  CampaignResults(
      {String map,
      int oil,
      int ammo,
      int steel,
      int aluminium,
      int ddCube,
      int clCube,
      int bbCube,
      int cvCube,
      int ssCube,
      int createTime})
      : _map = map,
        _oil = oil,
        _ammo = ammo,
        _steel = steel,
        _aluminium = aluminium,
        _ddCube = ddCube,
        _clCube = clCube,
        _bbCube = bbCube,
        _cvCube = cvCube,
        _ssCube = ssCube,
        _createTime = createTime;

  factory CampaignResults.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : CampaignResults(
              map: asT<String>(jsonRes['map']),
              oil: asT<int>(jsonRes['oil']),
              ammo: asT<int>(jsonRes['ammo']),
              steel: asT<int>(jsonRes['steel']),
              aluminium: asT<int>(jsonRes['aluminium']),
              ddCube: asT<int>(jsonRes['dd_cube']),
              clCube: asT<int>(jsonRes['cl_cube']),
              bbCube: asT<int>(jsonRes['bb_cube']),
              cvCube: asT<int>(jsonRes['cv_cube']),
              ssCube: asT<int>(jsonRes['ss_cube']),
              createTime: asT<int>(jsonRes['create_time']));

  String _map;

  String get map => _map;
  int _oil;

  int get oil => _oil;
  int _ammo;

  int get ammo => _ammo;
  int _steel;

  int get steel => _steel;
  int _aluminium;

  int get aluminium => _aluminium;
  int _ddCube;

  int get ddCube => _ddCube;
  int _clCube;

  int get clCube => _clCube;
  int _bbCube;

  int get bbCube => _bbCube;
  int _cvCube;

  int get cvCube => _cvCube;
  int _ssCube;

  int get ssCube => _ssCube;

  int _createTime;
  int get createTime => _createTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'map': _map,
        'oil': _oil,
        'ammo': _ammo,
        'steel': _steel,
        'aluminium': _aluminium,
        'dd_cube': _ddCube,
        'cl_cube': _clCube,
        'bb_cube': _bbCube,
        'cv_cube': _cvCube,
        'ss_cube': _ssCube,
        'create_time': createTime
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
