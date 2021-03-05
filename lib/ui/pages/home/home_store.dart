import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/dashboard.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase() {
    loadDashBoard();
  }

  @observable
  bool isLoading = false;

  @observable
  DashBoardBean dashBoardData;



  @action
  Future<void> loadDashBoard() async {
    isLoading = true;
    dashBoardData = await api.dashboard();
    isLoading = false;
  }
}
