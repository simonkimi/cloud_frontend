import 'package:cloud_frontend/network/api.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

final mainStore = MainStore();

class MainStore = MainStoreBase with _$MainStore;

abstract class MainStoreBase with Store {
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
  Future<void> login(String username, String password) async {
    this.username = username;
    this.password = username;
    final token = await api.login(username, password);
    api.token = token.token;
  }

  @action
  Future<void> getMine() async {
    final mine = await api.mine();
    final profile = mine.userProfile;
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
    print(mine);
  }
}
