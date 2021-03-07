import 'dart:convert' show json;

import '../utils.dart';

class StatisticBean {
  StatisticBean({
    int oil,
    int ammo,
    int steel,
    int aluminium,
    int fastRepair,
    int fastBuild,
    int buildMap,
    int equipmentMap,
    int ddCube,
    int clCube,
    int bbCube,
    int cvCube,
    int ssCube,
  })  : _oil = oil,
        _ammo = ammo,
        _steel = steel,
        _aluminium = aluminium,
        _fastRepair = fastRepair,
        _fastBuild = fastBuild,
        _buildMap = buildMap,
        _equipmentMap = equipmentMap,
        _ddCube = ddCube,
        _clCube = clCube,
        _bbCube = bbCube,
        _cvCube = cvCube,
        _ssCube = ssCube;

  factory StatisticBean.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : StatisticBean(
              oil: asT<int>(jsonRes['oil']),
              ammo: asT<int>(jsonRes['ammo']),
              steel: asT<int>(jsonRes['steel']),
              aluminium: asT<int>(jsonRes['aluminium']),
              fastRepair: asT<int>(jsonRes['fast_repair']),
              fastBuild: asT<int>(jsonRes['fast_build']),
              buildMap: asT<int>(jsonRes['build_map']),
              equipmentMap: asT<int>(jsonRes['equipment_map']),
              ddCube: asT<int>(jsonRes['dd_cube']),
              clCube: asT<int>(jsonRes['cl_cube']),
              bbCube: asT<int>(jsonRes['bb_cube']),
              cvCube: asT<int>(jsonRes['cv_cube']),
              ssCube: asT<int>(jsonRes['ss_cube']),
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'oil': _oil,
        'ammo': _ammo,
        'steel': _steel,
        'aluminium': _aluminium,
        'fast_repair': _fastRepair,
        'fast_build': _fastBuild,
        'build_map': _buildMap,
        'equipment_map': _equipmentMap,
        'dd_cube': _ddCube,
        'cl_cube': _clCube,
        'bb_cube': _bbCube,
        'cv_cube': _cvCube,
        'ss_cube': _ssCube,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
