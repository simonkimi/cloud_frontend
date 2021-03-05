import 'package:cloud_frontend/network/api.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_store.g.dart';

final mainStore = MainStore();

class MainStore = MainStoreBase with _$MainStore;

abstract class MainStoreBase with Store {
  MainStoreBase() {
    init();
  }

  @observable
  bool isInit = false;
  @observable
  bool isLogin;
  @observable
  String token;
  @observable
  String username;
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
    try {
      isLogin = false;
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';
      print('token: $token');
      this.token = token;
      if (token.isNotEmpty) {
        getMine();
        isLogin = true;
      }
    } finally {
      isInit = true;
    }
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
    final profile = mine.userProfile;
    username = mine.username;
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
  }
}
