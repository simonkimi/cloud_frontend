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
  Future<bool> login(String username, String password) async {
    final token = await api.login(username, password);
    api.token = token.token;
    return true;
  }

  @action
  Future<void> getMine() async {
    final mine = await api.mine();

  }
}
