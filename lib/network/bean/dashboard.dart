import 'dart:convert' show json;

import '../utils.dart';

class DashBoardBean {
  DashBoardBean({
    this.resource,
    this.explore,
    this.repair,
    this.build,
    this.equipment,
  });

  factory DashBoardBean.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<Explore> explore =
        jsonRes['explore'] is List ? <Explore>[] : null;
    if (explore != null) {
      for (final dynamic item in jsonRes['explore']) {
        if (item != null) {
          explore.add(Explore.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<Repair> repair = jsonRes['repair'] is List ? <Repair>[] : null;
    if (repair != null) {
      for (final dynamic item in jsonRes['repair']) {
        if (item != null) {
          repair.add(Repair.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<Build> build = jsonRes['build'] is List ? <Build>[] : null;
    if (build != null) {
      for (final dynamic item in jsonRes['build']) {
        if (item != null) {
          build.add(Build.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<Equipment> equipment =
        jsonRes['equipment'] is List ? <Equipment>[] : null;
    if (equipment != null) {
      for (final dynamic item in jsonRes['equipment']) {
        if (item != null) {
          equipment.add(Equipment.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return DashBoardBean(
      resource:
          Resource.fromJson(asT<Map<String, dynamic>>(jsonRes['resource'])),
      explore: explore,
      repair: repair,
      build: build,
      equipment: equipment,
    );
  }

  Resource resource;
  List<Explore> explore;
  List<Repair> repair;
  List<Build> build;
  List<Equipment> equipment;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resource': resource,
        'explore': explore,
        'repair': repair,
        'build': build,
        'equipment': equipment,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Resource {
  Resource({
    this.oil,
    this.ammo,
    this.steel,
    this.aluminium,
    this.ddCube,
    this.clCube,
    this.bbCube,
    this.cvCube,
    this.ssCube,
    this.fastRepair,
    this.fastBuild,
    this.buildMap,
    this.equipmentMap,
  });

  factory Resource.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Resource(
          oil: asT<int>(jsonRes['oil']),
          ammo: asT<int>(jsonRes['ammo']),
          steel: asT<int>(jsonRes['steel']),
          aluminium: asT<int>(jsonRes['aluminium']),
          ddCube: asT<int>(jsonRes['dd_cube']),
          clCube: asT<int>(jsonRes['cl_cube']),
          bbCube: asT<int>(jsonRes['bb_cube']),
          cvCube: asT<int>(jsonRes['cv_cube']),
          ssCube: asT<int>(jsonRes['ss_cube']),
          fastRepair: asT<int>(jsonRes['fast_repair']),
          fastBuild: asT<int>(jsonRes['fast_build']),
          buildMap: asT<int>(jsonRes['build_map']),
          equipmentMap: asT<int>(jsonRes['equipment_map']),
        );

  int oil;
  int ammo;
  int steel;
  int aluminium;
  int ddCube;
  int clCube;
  int bbCube;
  int cvCube;
  int ssCube;
  int fastRepair;
  int fastBuild;
  int buildMap;
  int equipmentMap;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'oil': oil,
        'ammo': ammo,
        'steel': steel,
        'aluminium': aluminium,
        'dd_cube': ddCube,
        'cl_cube': clCube,
        'bb_cube': bbCube,
        'cv_cube': cvCube,
        'ss_cube': ssCube,
        'fast_repair': fastRepair,
        'fast_build': fastBuild,
        'build_map': buildMap,
        'equipment_map': equipmentMap,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Explore {
  Explore({
    this.map,
    this.startTime,
    this.endTime,
  });

  factory Explore.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Explore(
          map: asT<String>(jsonRes['map']),
          startTime: asT<int>(jsonRes['start_time']),
          endTime: asT<int>(jsonRes['end_time']),
        );

  String map;
  int startTime;
  int endTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'map': map,
        'start_time': startTime,
        'end_time': endTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Repair {
  Repair({
    this.name,
    this.startTime,
    this.endTime,
  });

  factory Repair.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Repair(
          name: asT<String>(jsonRes['name']),
          startTime: asT<int>(jsonRes['start_time']),
          endTime: asT<int>(jsonRes['end_time']),
        );

  String name;
  int startTime;
  int endTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'start_time': startTime,
        'end_time': endTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Build {
  Build({
    this.type,
    this.startTime,
    this.endTime,
  });

  factory Build.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Build(
          type: asT<int>(jsonRes['type']),
          startTime: asT<int>(jsonRes['start_time']),
          endTime: asT<int>(jsonRes['end_time']),
        );

  int type;
  int startTime;
  int endTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'start_time': startTime,
        'end_time': endTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Equipment {
  Equipment({
    this.cid,
    this.startTime,
    this.endTime,
  });

  factory Equipment.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Equipment(
          cid: asT<int>(jsonRes['cid']),
          startTime: asT<int>(jsonRes['start_time']),
          endTime: asT<int>(jsonRes['end_time']),
        );

  int cid;
  int startTime;
  int endTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cid': cid,
        'start_time': startTime,
        'end_time': endTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
