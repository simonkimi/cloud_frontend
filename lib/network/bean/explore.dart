import 'dart:convert' show json;

import 'package:cloud_frontend/network/bean/pagination_base.dart';

import '../utils.dart';

class ExploreBean extends PaginationBase<ExploreResult> {
  ExploreBean({
    int count,
    String next,
    String previous,
    List<ExploreResult> results,
  })  : _count = count,
        _next = next,
        _previous = previous,
        _results = results;

  factory ExploreBean.fromJson(Map<String, dynamic> jsonRes) {
    if (ExploreBean == null) {
      return null;
    }
    final List<ExploreResult> results =
        jsonRes['results'] is List ? <ExploreResult>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']) {
        if (item != null) {
          results.add(ExploreResult.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return ExploreBean(
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
  List<ExploreResult> _results;

  @override
  List<ExploreResult> get results => _results;

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

class ExploreResult {
  ExploreResult({
    String map,
    int createTime,
    bool success,
    int oil,
    int ammo,
    int steel,
    int aluminium,
    int fastRepair,
    int fastBuild,
    int buildMap,
    int equipmentMap,
  })  : _map = map,
        _createTime = createTime,
        _success = success,
        _oil = oil,
        _ammo = ammo,
        _steel = steel,
        _aluminium = aluminium,
        _fastRepair = fastRepair,
        _fastBuild = fastBuild,
        _buildMap = buildMap,
        _equipmentMap = equipmentMap;

  factory ExploreResult.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ExploreResult(
              map: asT<String>(jsonRes['map']),
              createTime: asT<int>(jsonRes['create_time']),
              success: asT<bool>(jsonRes['success']),
              oil: asT<int>(jsonRes['oil']),
              ammo: asT<int>(jsonRes['ammo']),
              steel: asT<int>(jsonRes['steel']),
              aluminium: asT<int>(jsonRes['aluminium']),
              fastRepair: asT<int>(jsonRes['fast_repair']),
              fastBuild: asT<int>(jsonRes['fast_build']),
              buildMap: asT<int>(jsonRes['build_map']),
              equipmentMap: asT<int>(jsonRes['equipment_map']),
            );

  String _map;

  String get map => _map;
  int _createTime;

  int get createTime => _createTime;
  bool _success;

  bool get success => _success;
  int _oil;

  int get oil => _oil;
  int _ammo;

  int get ammo => _ammo;
  int _steel;

  int get steel => _steel;
  int _aluminium;

  int get aluminium => _aluminium;
  int _fastRepair;

  int get fastRepair => _fastRepair;
  int _fastBuild;

  int get fastBuild => _fastBuild;
  int _buildMap;

  int get buildMap => _buildMap;
  int _equipmentMap;

  int get equipmentMap => _equipmentMap;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'map': _map,
        'create_time': _createTime,
        'success': _success,
        'oil': _oil,
        'ammo': _ammo,
        'steel': _steel,
        'aluminium': _aluminium,
        'fast_repair': _fastRepair,
        'fast_build': _fastBuild,
        'build_map': _buildMap,
        'equipment_map': _equipmentMap,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ExploreStatistic {
  ExploreStatistic({
    int oil,
    int ammo,
    int steel,
    int aluminium,
    int fastRepair,
    int fastBuild,
    int buildMap,
    int equipmentMap,
  })  : _oil = oil,
        _ammo = ammo,
        _steel = steel,
        _aluminium = aluminium,
        _fastRepair = fastRepair,
        _fastBuild = fastBuild,
        _buildMap = buildMap,
        _equipmentMap = equipmentMap;

  factory ExploreStatistic.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ExploreStatistic(
              oil: asT<int>(jsonRes['oil']),
              ammo: asT<int>(jsonRes['ammo']),
              steel: asT<int>(jsonRes['steel']),
              aluminium: asT<int>(jsonRes['aluminium']),
              fastRepair: asT<int>(jsonRes['fast_repair']),
              fastBuild: asT<int>(jsonRes['fast_build']),
              buildMap: asT<int>(jsonRes['build_map']),
              equipmentMap: asT<int>(jsonRes['equipment_map']),
            );

  int _oil;

  int get oil => _oil;
  int _ammo;

  int get ammo => _ammo;
  int _steel;

  int get steel => _steel;
  int _aluminium;

  int get aluminium => _aluminium;
  int _fastRepair;

  int get fastRepair => _fastRepair;
  int _fastBuild;

  int get fastBuild => _fastBuild;
  int _buildMap;

  int get buildMap => _buildMap;
  int _equipmentMap;

  int get equipmentMap => _equipmentMap;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'oil': _oil,
        'ammo': _ammo,
        'steel': _steel,
        'aluminium': _aluminium,
        'fast_repair': _fastRepair,
        'fast_build': _fastBuild,
        'build_map': _buildMap,
        'equipment_map': _equipmentMap,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
