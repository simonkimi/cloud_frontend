import 'dart:convert' show json;

import '../utils.dart';

class MineBean {
  MineBean({
    this.username,
    this.userProfile,
  });

  factory MineBean.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : MineBean(
          username: asT<String>(jsonRes['username']),
          userProfile: UserProfile.fromJson(
              asT<Map<String, dynamic>>(jsonRes['user_profile'])),
        );

  String username;
  UserProfile userProfile;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'user_profile': userProfile,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class UserProfile {
  UserProfile(
      {this.username,
      this.server,
      this.mainSwitch,
      this.point,
      this.lastTime,
      this.nextTime,
      this.exploreSwitch,
      this.campaignMap,
      this.campaignFormat,
      this.pvpFleet,
      this.pvpFormat,
      this.pvpNight,
      this.repairSwitch,
      this.buildSwitch,
      this.buildOil,
      this.buildAmmo,
      this.buildSteel,
      this.buildAluminium,
      this.equipmentSwitch,
      this.equipmentOil,
      this.equipmentAmmo,
      this.equipmentSteel,
      this.equipmentAluminium,
      this.dormEvent,
      this.sign,
      this.level});

  factory UserProfile.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : UserProfile(
          username: asT(jsonRes['username']),
          server: asT<int>(jsonRes['server']),
          mainSwitch: asT<bool>(jsonRes['switch']),
          point: asT<int>(jsonRes['point']),
          lastTime: asT<int>(jsonRes['last_time']),
          nextTime: asT<int>(jsonRes['next_time']),
          exploreSwitch: asT<bool>(jsonRes['explore_switch']),
          campaignMap: asT<int>(jsonRes['campaign_map']),
          campaignFormat: asT<int>(jsonRes['campaign_format']),
          pvpFleet: asT<int>(jsonRes['pvp_fleet']),
          pvpFormat: asT<int>(jsonRes['pvp_format']),
          pvpNight: asT<bool>(jsonRes['pvp_night']),
          repairSwitch: asT<bool>(jsonRes['repair_switch']),
          buildSwitch: asT<bool>(jsonRes['build_switch']),
          buildOil: asT<int>(jsonRes['build_oil']),
          buildAmmo: asT<int>(jsonRes['build_ammo']),
          buildSteel: asT<int>(jsonRes['build_steel']),
          buildAluminium: asT<int>(jsonRes['build_aluminium']),
          equipmentSwitch: asT<bool>(jsonRes['equipment_switch']),
          equipmentOil: asT<int>(jsonRes['equipment_oil']),
          equipmentAmmo: asT<int>(jsonRes['equipment_ammo']),
          equipmentSteel: asT<int>(jsonRes['equipment_steel']),
          equipmentAluminium: asT<int>(jsonRes['equipment_aluminium']),
          dormEvent: asT<bool>(jsonRes['dorm_event']),
          sign: asT<String>(jsonRes['sign']),
          level: asT<int>(jsonRes['level']),
        );
  String username;
  int server;

  bool mainSwitch;
  String sign;
  int level;
  int point;
  int lastTime;
  int nextTime;
  bool exploreSwitch;
  int campaignMap;
  int campaignFormat;
  int pvpFleet;
  int pvpFormat;
  bool pvpNight;
  bool repairSwitch;
  bool buildSwitch;
  int buildOil;
  int buildAmmo;
  int buildSteel;
  int buildAluminium;
  bool equipmentSwitch;
  int equipmentOil;
  int equipmentAmmo;
  int equipmentSteel;
  int equipmentAluminium;
  bool dormEvent;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'server': server,
        'switch': mainSwitch,
        'point': point,
        'last_time': lastTime,
        'next_time': nextTime,
        'explore_switch': exploreSwitch,
        'campaign_map': campaignMap,
        'campaign_format': campaignFormat,
        'pvp_fleet': pvpFleet,
        'pvp_format': pvpFormat,
        'pvp_night': pvpNight,
        'repair_switch': repairSwitch,
        'build_switch': buildSwitch,
        'build_oil': buildOil,
        'build_ammo': buildAmmo,
        'build_steel': buildSteel,
        'build_aluminium': buildAluminium,
        'equipment_switch': equipmentSwitch,
        'equipment_oil': equipmentOil,
        'equipment_ammo': equipmentAmmo,
        'equipment_steel': equipmentSteel,
        'equipment_aluminium': equipmentAluminium,
        'dorm_event': dormEvent,
        'sign': sign,
        'level': level
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
