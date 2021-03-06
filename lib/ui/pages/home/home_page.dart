import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/constant.dart';

import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/dashboard.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_frontend/utils/time_utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

mixin _HomePageStateMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = true;
  DashBoardBean dashBoardData;
  bool isSwitchLoading = false;

  Future<void> loadDashBoard() async {
    dashBoardData = await api.dashboard();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onSwitchTap(bool value) async {
    try {
      setState(() {
        isSwitchLoading = true;
      });
      await mainStore.setSwitch(value);
    } on DioError catch (e) {
      BotToast.showText(text: getDioErr(e));
    } finally {
      setState(() {
        isSwitchLoading = false;
      });
    }
  }
}

class _HomePageState extends State<HomePage> with _HomePageStateMixin {
  @override
  void initState() {
    super.initState();
    if (mainStore.isLogin) {
      loadDashBoard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(tag: 'home'),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '主页',
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildHeader() {
    return Observer(builder: (_) {
      return Card(
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/imgs/t.png'),
          ),
          title: Text('${SERVER_LIST[mainStore.server]} 提督 Lv.${mainStore.level} '),
          subtitle: Text(mainStore.sign),
          trailing: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSwitchLoading ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ) : Switch(
              value: mainStore.mainSwitch,
              onChanged: onSwitchTap,
            ),
          ),
        ),
      );
    });
  }

  Widget buildBody(BuildContext context) {
    if (!mainStore.isLogin) {
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('login/', (route) => false);
      });
      return Container();
    }
    if (isLoading) {
      return buildLoading();
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          buildHeader(),
          const SizedBox(height: 10),
          buildMine(),
          const SizedBox(height: 10),
          buildRes(),
          const SizedBox(height: 10),
          buildExplore(),
          const SizedBox(height: 10),
          buildRepair(),
          const SizedBox(height: 10),
          buildBuildShip(),
          const SizedBox(height: 10),
          buildEquipment()
        ],
      ),
    );
  }

  Widget buildResItem(String imgPath, String text) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/imgs/$imgPath'),
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 3),
          Text(text)
        ],
      ),
    );
  }

  Widget buildMine() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('基础数据'),
              const SizedBox(height: 5),
              Text(
                  '上次登录时间: ${mainStore.lastLoginTime.bySeconds.toLocal().toString()}'),
              const SizedBox(height: 3),
              Text(
                  '下次登录时间: ${mainStore.nextLoginTime.bySeconds.toLocal().toString()}'),
              const SizedBox(height: 3),
              Text('点数: ${mainStore.point}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBuildShip() {
    final buildList = List.generate(7, (index) {
      if (index.isOdd) {
        return const SizedBox(
          width: 5,
        );
      }
      index ~/= 2;
      if (index < dashBoardData.build.length) {
        final stamp = DateTime.now().millisecondsSinceEpoch / 1000;
        final build = dashBoardData.build[index];
        var time = build.endTime - stamp;
        time = time < 0 ? 0 : time / 60;
        final hour = time ~/ 60;
        final minute = (time - hour * 60).floor();
        return Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                Text(SHIP_TYPE.containsKey(build.type)
                    ? SHIP_TYPE[build.type]
                    : '未知'),
                Text(time == 0
                    ? '已完成'
                    : '剩余${hour == 0 ? '00' : hour}:${minute < 10 ? '0' : ''}$minute'),
              ],
            ),
          ),
        );
      }
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: const [Text('空闲'), Text('')],
          ),
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('建造列表'),
              const SizedBox(height: 5),
              Row(
                children: buildList,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEquipment() {
    final buildList = List.generate(7, (index) {
      if (index.isOdd) {
        return const SizedBox(
          width: 5,
        );
      }
      index ~/= 2;
      if (index < dashBoardData.equipment.length) {
        final stamp = DateTime.now().millisecondsSinceEpoch / 1000;
        final equipment = dashBoardData.equipment[index];
        var time = equipment.endTime - stamp;
        time = time < 0 ? 0 : time;
        time /= 60;
        final hour = time ~/ 60;
        final minute = (time - hour * 60).floor();
        return Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                Text('位置${index + 1}'),
                Text(time == 0
                    ? '已完成'
                    : '剩余${hour == 0 ? '00' : hour}:${minute < 10 ? '0' : ''}$minute'),
              ],
            ),
          ),
        );
      }
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: const [Text('空闲'), Text('')],
          ),
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('开发列表'),
              const SizedBox(height: 5),
              Row(
                children: buildList,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRepair() {
    final repairList = List.generate(7, (index) {
      if (index.isOdd) {
        return const SizedBox(
          width: 5,
        );
      }
      index ~/= 2;
      if (index < dashBoardData.repair.length) {
        final stamp = DateTime.now().millisecondsSinceEpoch / 1000;
        final repair = dashBoardData.repair[index];
        var time = repair.endTime - stamp;
        time = time < 0 ? 0 : time;
        time /= 60;
        final hour = time ~/ 60;
        final minute = (time - hour * 60).floor();
        return Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                Text(repair.name),
                Text(time == 0
                    ? '已完成'
                    : '剩余${hour == 0 ? '00' : hour}:${minute < 10 ? '0' : ''}$minute'),
              ],
            ),
          ),
        );
      }
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: const [Text('空闲'), Text('')],
          ),
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('修理列表'),
              const SizedBox(height: 5),
              Row(
                children: repairList,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExplore() {
    final exploreList = List.generate(7, (index) {
      if (index.isOdd) {
        return const SizedBox(
          width: 5,
        );
      }
      index ~/= 2;
      if (index < dashBoardData.explore.length) {
        final stamp = DateTime.now().millisecondsSinceEpoch / 1000;
        final explore = dashBoardData.explore[index];
        var time = explore.endTime - stamp;
        time = time < 0 ? 0 : time;
        time /= 60;
        final hour = time ~/ 60;
        final minute = (time - hour * 60).floor();
        return Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              children: [
                Text(explore.map.replaceAll('000', '-')),
                Text(time == 0
                    ? '已完成'
                    : '剩余${hour == 0 ? '00' : hour}:${minute < 10 ? '0' : ''}$minute'),
              ],
            ),
          ),
        );
      }
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: const [Text('空闲'), Text('')],
          ),
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('远征列表'),
              const SizedBox(height: 5),
              Row(
                children: exploreList,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRes() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('资源列表'),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem(
                      'you.png', dashBoardData.resource.oil.toString()),
                  buildResItem(
                      'dan.png', dashBoardData.resource.ammo.toString()),
                  buildResItem(
                      'gang.png', dashBoardData.resource.steel.toString()),
                  buildResItem(
                      'lv.png', dashBoardData.resource.aluminium.toString()),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem(
                      'jl.png', dashBoardData.resource.buildMap.toString()),
                  buildResItem('zblt.png',
                      dashBoardData.resource.equipmentMap.toString()),
                  buildResItem(
                      'kj.png', dashBoardData.resource.fastBuild.toString()),
                  buildResItem(
                      'kx.png', dashBoardData.resource.fastRepair.toString()),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem(
                      'qz.png', dashBoardData.resource.ddCube.toString()),
                  buildResItem(
                      'xy.png', dashBoardData.resource.clCube.toString()),
                  buildResItem(
                      'zl.png', dashBoardData.resource.bbCube.toString()),
                  buildResItem(
                      'hm.png', dashBoardData.resource.cvCube.toString()),
                  buildResItem(
                      'qt.png', dashBoardData.resource.ssCube.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
