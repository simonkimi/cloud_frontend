import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/mine.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_store.g.dart';

final mainStore = MainStore();

class MainStore = MainStoreBase with _$MainStore;

abstract class MainStoreBase with Store {
  @observable
  bool isLogin = false;
  @observable
  String token;
  @observable
  String username;
  @observable
  String sign;
  @observable
  int level;
  @observable
  String nickname;
  @observable
  String password;
  @observable
  int server;
  @observable
  int point;
  @observable
  int lastLoginTime;
  @observable
  int nextLoginTime;
  @observable
  bool mainSwitch;
  @observable
  bool exploreSwitch;
  @observable
  int campaignMap;
  @observable
  int campaignFormat;
  @observable
  int pvpFleet;
  @observable
  int pvpFormat;
  @observable
  bool pvpNight;
  @observable
  bool repairSwitch;
  @observable
  bool buildSwitch;
  @observable
  int buildOil;
  @observable
  int buildAmmo;
  @observable
  int buildSteel;
  @observable
  int buildAluminium;
  @observable
  bool equipmentSwitch;
  @observable
  int equipmentOil;
  @observable
  int equipmentAmmo;
  @observable
  int equipmentSteel;
  @observable
  int equipmentAluminium;
  @observable
  bool dormEvent;

  @action
  Future<void> init() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? '';
    this.token = token;
    if (token.isNotEmpty) {
      isLogin = true;
      getMine();
    }
  }

  @action
  Future<void> setSwitch(bool value) async {
    final profile = await api.setSwitch(value);
    await setUserProfile(profile);
  }

  @action
  Future<void> setExploreSwitch(bool value) async {
    final profile = await api.setExploreSwitch(value);
    await setUserProfile(profile);
  }

  @action
  Future<void> setRepairSwitch(bool value) async {
    final profile = await api.setRepairSwitch(value);
    await setUserProfile(profile);
  }

  @action
  Future<void> setCampaignSetting(int map, int formats) async {
    final profile = await api.setCampaignSetting(map, formats);
    await setUserProfile(profile);
  }

  @action
  Future<void> setBuildSetting(
      bool value, int oil, int ammo, int steel, int aluminium) async {
    final profile =
        await api.setBuildSetting(value, oil, ammo, steel, aluminium);
    await setUserProfile(profile);
  }

  @action
  Future<void> setEquipmentSetting(
      bool value, int oil, int ammo, int steel, int aluminium) async {
    final profile =
        await api.setEquipmentSetting(value, oil, ammo, steel, aluminium);
    await setUserProfile(profile);
  }

  @action
  Future<void> setPvpSetting(int fleet, int formats, bool isNight) async {
    final profile = await api.setPvpSetting(fleet, formats, isNight);
    await setUserProfile(profile);
  }

  @action
  Future<void> login(String username, String password) async {
    this.username = username;
    this.password = username;
    final token = await api.login(username, password);
    this.token = token.token;
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token.token);
    print('设置Token ${token.token}');
    isLogin = true;
  }

  @action
  Future<void> register(String username, String password, int server) async {
    this.username = username;
    this.password = username;
    final token = await api.register(username, password, server);
    this.token = token.token;
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token.token);
    print('设置Token ${token.token}');
    isLogin = true;
  }

  @action
  Future<void> logout() async {
    print('login out');
    isLogin = false;
    token = '';
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', '');
  }

  @action
  Future<void> getMine() async {
    final mine = await api.mine();
    username = mine.username;
    await setUserProfile(mine.userProfile);
  }

  @action
  Future<void> setUserProfile(UserProfile profile) async {
    nickname = profile.username;
    server = profile.server;
    mainSwitch = profile.mainSwitch;
    point = profile.point;
    lastLoginTime = profile.lastTime;
    nextLoginTime = profile.nextTime;
    exploreSwitch = profile.exploreSwitch;
    campaignMap = profile.campaignMap;
    campaignFormat = profile.campaignFormat;
    pvpFleet = profile.pvpFleet;
    pvpFormat = profile.pvpFormat;
    pvpNight = profile.pvpNight;
    repairSwitch = profile.repairSwitch;
    buildSwitch = profile.buildSwitch;
    buildOil = profile.buildOil;
    buildAmmo = profile.buildAmmo;
    buildSteel = profile.buildSteel;
    buildAluminium = profile.buildAluminium;
    equipmentSwitch = profile.equipmentSwitch;
    equipmentOil = profile.equipmentOil;
    equipmentAmmo = profile.equipmentAmmo;
    equipmentSteel = profile.equipmentSteel;
    equipmentAluminium = profile.equipmentAluminium;
    dormEvent = profile.dormEvent;
    sign = profile.sign;
    level = profile.level;
  }
}
